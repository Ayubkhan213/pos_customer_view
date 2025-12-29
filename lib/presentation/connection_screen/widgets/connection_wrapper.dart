import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';
import 'package:tenxglobal_customer/presentation/connection_screen/provider/connection_provider.dart';
import 'package:tenxglobal_customer/presentation/connection_screen/screen/connection_screen.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  void initState() {
    super.initState();
    _initConnectivityListener();
  }

  void _initConnectivityListener() {
    // Listen to connectivity changes
    _subscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      if (!mounted) return;

      final provider = Provider.of<ConnectionProvider>(context, listen: false);

      // Check if disconnected
      final isDisconnected =
          results.isEmpty || results.first == ConnectivityResult.none;

      print('Connectivity changed: $results');
      print('Is disconnected: $isDisconnected');
      print('Is authenticated: ${provider.isAuthenticated}');

      // If user is authenticated and WiFi disconnects, redirect to connection screen
      if (isDisconnected && provider.isAuthenticated) {
        print('Redirecting to ConnectionScreen...');
        provider.logout();

        // Navigate to connection screen and remove all previous routes
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const ConnectionScreen()),
          (route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
