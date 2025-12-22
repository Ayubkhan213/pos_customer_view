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

//window
Future<String?> getActiveLanIp() async {
  try {
    final interfaces = await NetworkInterface.list(
      includeLoopback: false,
      type: InternetAddressType.IPv4,
    );

    for (final interface in interfaces) {
      // Skip virtual / unwanted adapters by name
      final name = interface.name.toLowerCase();

      if (name.contains('virtual') ||
          name.contains('vm') ||
          name.contains('hyper') ||
          name.contains('docker') ||
          name.contains('loopback')) {
        continue;
      }

      for (final addr in interface.addresses) {
        final ip = addr.address;

        // Skip link-local
        if (ip.startsWith('169.254')) continue;

        // Accept private LAN IP
        if (_isPrivateIPv4(ip)) {
          return ip;
        }
      }
    }
  } catch (e) {
    print('IP error: $e');
  }
  return null;
}

//window
Future<List<String>> getUsableLanIps() async {
  final ips = <String>[];

  final interfaces = await NetworkInterface.list(
    includeLoopback: false,
    type: InternetAddressType.IPv4,
  );

  for (final interface in interfaces) {
    for (final addr in interface.addresses) {
      final ip = addr.address;

      if (_isPrivateIPv4(ip) && !ip.startsWith('169.254')) {
        ips.add(ip);
      }
    }
  }
  return ips;
}

//window
bool _isPrivateIPv4(String ip) {
  final parts = ip.split('.').map(int.parse).toList();

  // 10.0.0.0 – 10.255.255.255
  if (parts[0] == 10) return true;

  // 172.16.0.0 – 172.31.255.255
  if (parts[0] == 172 && parts[1] >= 16 && parts[1] <= 31) return true;

  // 192.168.0.0 – 192.168.255.255
  if (parts[0] == 192 && parts[1] == 168) return true;

  return false;
}

/* -------------------- NETWORK HELPERS -------------------- */
//Mobile
// Future<String?> getWifiIp() async {
//   try {
//     for (var interface in await NetworkInterface.list()) {
//       for (var addr in interface.addresses) {
//         if (addr.type == InternetAddressType.IPv4 &&
//             !addr.isLoopback &&
//             !addr.address.startsWith("127")) {
//           // Accept first non-loopback IPv4 address
//           return addr.address;
//         }
//       }
//     }
//   } catch (e) {
//     print("Error getting IP: $e");
//   }
//   return null;
// }

/* -------------------- HTTP SERVER -------------------- */

Future<void> startServer() async {
  //mobile
  // final ip = await getWifiIp();

  final server = await HttpServer.bind(
    InternetAddress.anyIPv4, // 0.0.0.0
    51234,
  );
  //window
  final ips = await getUsableLanIps();
  for (final ip in ips) {
    // print('Server available at → http://$ip:51234');
    print('POST → http://$ip:51234/data');
    print('GET  → http://$ip:51234/hello');
  }
  //========================================//

  //mobile
  // print('Server started!');
  // print('GET  → http://$ip:51234/hello');
  // print('POST → http://$ip:51234/data');
  //===============================//
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


// import 'dart:io';

// class CashDrawerService {
//   static const int defaultPort = 9100; // Xprinter LAN usually 9100

//   // Try method A then B (best for Xprinter variations)
//   static Future<void> open({
//     required String ip,
//     int port = defaultPort,
//   }) async {
//     final kickA = <int>[0x1B, 0x70, 0x00, 0x19, 0xFA];
//     final kickB = <int>[0x1B, 0x70, 0x00, 0x3C, 0xFF];

//     // Attempt A
//     final okA = await _send(ip, port, kickA);
//     if (okA) return;

//     // Attempt B
//     await _send(ip, port, kickB);
//   }

//   static Future<bool> _send(String ip, int port, List<int> bytes) async {
//     Socket? socket;
//     try {
//       socket = await Socket.connect(ip, port, timeout: const Duration(seconds: 3));
//       socket.add(bytes);
//       await socket.flush();
//       return true;
//     } catch (_) {
//       return false;
//     } finally {
//       await socket?.close();
//     }
//   }
// }