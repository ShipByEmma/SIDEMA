import 'package:flutter/material.dart';

class ConnectionStatus extends StatelessWidget {
  final bool isConnected;

  const ConnectionStatus({
    super.key,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isConnected ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isConnected ? Colors.green : Colors.red,
          width: 3,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isConnected ? Icons.check_circle : Icons.error,
            color: isConnected ? Colors.green : Colors.red,
            size: 80,
          ),
          const SizedBox(height: 16),
          Text(
            isConnected ? 'ESP32 CONECTADO' : 'ESP32 DESCONECTADO',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isConnected ? Colors.green.shade900 : Colors.red.shade900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isConnected ? '192.168.4.22' : 'Sin conexión',
            style: TextStyle(
              fontSize: 16,
              color: isConnected ? Colors.green.shade700 : Colors.red.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
