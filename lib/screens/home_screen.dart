import 'dart:async';
import 'package:flutter/material.dart';
import '../services/esp32_service.dart';
import '../widgets/connection_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Esp32Service _esp32Service = Esp32Service();
  bool _isConnected = false;
  Timer? _connectionTimer;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    _startConnectionCheck();
  }

  @override
  void dispose() {
    _connectionTimer?.cancel();
    super.dispose();
  }

  void _startConnectionCheck() {
    _connectionTimer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) => _checkConnection(),
    );
  }

  Future<void> _checkConnection() async {
    final isConnected = await _esp32Service.checkConexion();
    if (mounted) {
      setState(() {
        _isConnected = isConnected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/sidema_logo.png',
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
          'SIDEMA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/sidema_logo.png',
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Sistema de Descongelado',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ConnectionStatus(isConnected: _isConnected),
                const SizedBox(height: 24),
                if (_isConnected)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.wifi,
                          color: Colors.blue.shade700,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Red: Descongelador',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
