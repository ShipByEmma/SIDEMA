import 'package:flutter/material.dart';
import '../services/esp32_service.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  final Esp32Service _esp32Service = Esp32Service();
  bool _isLoading = false;

  Future<void> _handleAction(
    Future<bool> Function() action,
    String actionName,
  ) async {
    setState(() => _isLoading = true);
    
    try {
      final success = await action();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? '$actionName ejecutado' : 'Error en $actionName',
            ),
            backgroundColor: success ? Colors.green : Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildControlButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    bool isPrimary = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: isPrimary ? 100 : 80,
      child: ElevatedButton(
        onPressed: _isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: color.withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: isPrimary ? 48 : 36),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: isPrimary ? 24 : 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'CONTROL DEL SISTEMA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange.shade800,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildControlButton(
                label: 'INICIAR SISTEMA',
                icon: Icons.play_arrow,
                color: Colors.green.shade600,
                isPrimary: true,
                onPressed: () => _handleAction(
                  _esp32Service.activar,
                  'Iniciar llenado',
                ),
              ),
              const SizedBox(height: 20),
              _buildControlButton(
                label: 'DETENER SISTEMA',
                icon: Icons.stop,
                color: Colors.red.shade600,
                onPressed: () => _handleAction(
                  _esp32Service.desactivar,
                  'Detener sistema',
                ),
              ),
              const SizedBox(height: 20),
              _buildControlButton(
                label: 'VACIAR TANQUE',
                icon: Icons.water_drop,
                color: Colors.blue.shade600,
                onPressed: () => _handleAction(
                  _esp32Service.vaciar,
                  'Vaciar tambo',
                ),
              ),
              const SizedBox(height: 20),
              _buildControlButton(
                label: 'DETENER VACIADO',
                icon: Icons.pause,
                color: Colors.orange.shade600,
                onPressed: () => _handleAction(
                  _esp32Service.detener,
                  'Detener vaciado',
                ),
              ),
              if (_isLoading) ...[
                const SizedBox(height: 32),
                const CircularProgressIndicator(
                  strokeWidth: 6,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
