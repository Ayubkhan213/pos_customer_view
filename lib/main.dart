import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tenxglobal_customer/models/cart_data_model.dart';

import 'package:tenxglobal_customer/presentation/customer/provider/customer_provider.dart';
import 'package:tenxglobal_customer/presentation/customer/screen/customer_screen.dart';

///  Global navigator key (IMPORTANT)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await startServer();
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
    InternetAddress.anyIPv4, // 0.0.0.0
    51234,
  );

  print('Server started!');
  print('GET  → http://$ip:51234/hello');
  print('POST → http://$ip:51234/data');

  server.listen(handleRequest);
}

void handleRequest(HttpRequest request) async {
  //  GET
  if (request.method == 'GET' && request.uri.path == '/hello') {
    request.response
      ..statusCode = HttpStatus.ok
      ..headers.contentType = ContentType.json
      ..write(
        jsonEncode({
          "status": "success",
          "message": "Hello from Flutter server",
        }),
      );
  }
  //  POST (MAIN LOGIC)
  else if (request.method == 'POST' && request.uri.path == '/data') {
    final body = await utf8.decoder.bind(request).join();
    final decoded = jsonDecode(body);

    print('Received POST data: $decoded');

    //  Parse JSON → Model
    final orderResponse = OrderResponse.fromJson(decoded);

    // Access Provider safely
    final context = navigatorKey.currentContext;
    if (context != null) {
      Provider.of<CustomerProvider>(
        context,
        listen: false,
      ).addOrderFromJson(decoded);
    }

    request.response
      ..statusCode = HttpStatus.ok
      ..headers.contentType = ContentType.json
      ..write(
        jsonEncode({"status": "success", "message": "Order received & added"}),
      );
  }
  //  Unknown route
  else {
    request.response
      ..statusCode = HttpStatus.notFound
      ..write('Route not found');
  }

  await request.response.close();
}

/* -------------------- APP -------------------- */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CustomerProvider(),
          // ..addOrdersFromJsonList([DummyData.dummyOrderResponseJson]),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey, //  REQUIRED
        debugShowCheckedModeBanner: false,
        home: CustomerScreen(),
      ),
    );
  }
}
