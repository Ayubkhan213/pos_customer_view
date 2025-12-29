import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenxglobal_customer/core/api_services/network_api_services.dart';

import 'package:tenxglobal_customer/presentation/customer/provider/customer_provider.dart';
import 'package:tenxglobal_customer/presentation/customer/screen/customer_screen.dart';

///  Global navigator key (IMPORTANT)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await startServer();
  runApp(const MyApp());
}

/* -------------------- NETWORK HELPERS -------------------- */

Future<String?> getWifiIp() async {
  try {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4 &&
            !addr.isLoopback &&
            !addr.address.startsWith("127")) {
          // Accept first non-loopback IPv4 address
          return addr.address;
        }
      }
    }
  } catch (e) {
    print("Error getting IP: $e");
  }
  return null;
}

/* -------------------- HTTP SERVER -------------------- */

Future<void> startServer() async {
  final ip = await getWifiIp();

  final server = await HttpServer.bind(
    InternetAddress.anyIPv4,
    51234,
    shared: true,
  );

  print('Server started!');
  print('POST → http://$ip:51234/data');

  await for (HttpRequest request in server) {
    print('--------------------');
    print('${request.method} ${request.uri}');

    // =========================
    // CORS HEADERS (MUST BE FIRST)
    // =========================
    final origin = request.headers.value('origin');

    if (origin != null) {
      request.response.headers
        ..set('Access-Control-Allow-Origin', origin)
        ..set('Access-Control-Allow-Credentials', 'true');
    }

    request.response.headers
      ..set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
      ..set(
        'Access-Control-Allow-Headers',
        'Origin, Content-Type, Accept, Authorization, X-Requested-With, X-CSRF-Token',
      )
      ..set('Content-Type', 'application/json');

    // =========================
    // OPTIONS (PRE-FLIGHT)
    // =========================
    if (request.method == 'OPTIONS') {
      request.response.statusCode = HttpStatus.noContent; // 204
      await request.response.close();
      continue;
    }

    // =========================
    // POST /data (THIS WAS MISSING )
    // =========================
    if (request.method == 'POST' && request.uri.path == '/data') {
      final body = await utf8.decoder.bind(request).join();
      print(' POST DATA RECEIVED:');

      var res = jsonDecode(body);
      print('--------------------------------');
      print(res);

      // Access Provider safely
      final context = navigatorKey.currentContext;
      if (context != null) {
        Provider.of<CustomerProvider>(
          context,
          listen: false,
        ).addOrderFromJson(res);
      }
      // print(body);

      request.response
        ..statusCode = 200
        ..write(jsonEncode({'status': 'SUCCESS', 'message': 'Data received'}))
        ..close();

      continue;
    }

    // =========================
    // NOT FOUND
    // =========================
    request.response
      ..statusCode = 404
      ..write(jsonEncode({'error': 'Not Found'}))
      ..close();
  }
}

/* -------------------- APP -------------------- */

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    startServer(); // now navigatorKey.currentContext will be available
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CustomerProvider(apiServices: NetworkApiServices()),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: CustomerScreen(),
      ),
    );
  }
}
