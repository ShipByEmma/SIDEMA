import 'dart:async';
import 'package:flutter/material.dart';
import '../services/esp32_service.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({super.key});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  final Esp32Service _esp32Service = Esp32Service();
  double? _temperatura;
  Timer? _tempTimer;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTemperature();
    _startTemperatureUpdates();
  }

  @override
  void dispose() {
    _tempTimer?.cancel();
    super.dispose();
  }

  void _startTemperatureUpdates() {
    _tempTimer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) => _fetchTemperature(),
    );
  }

  Future<void> _fetchTemperature() async {
    final temp = await _esp32Service.getTemperatura();
    if (mounted) {
      setState(() {
        _temperatura = temp;
        _isLoading = false;
      });
    }
  }

  Color _getTemperatureColor(double? temp) {
    if (temp == null) return Colors.grey;
    if (temp < 10) return Colors.blue.shade700;
    if (temp < 20) return Colors.cyan.shade600;
    if (temp < 30) return Colors.green.shade600;
    if (temp < 40) return Colors.orange.shade600;
    return Colors.red.shade600;
  }

  IconData _getTemperatureIcon(double? temp) {
    if (temp == null) return Icons.device_thermostat;
    if (temp < 20) return Icons.ac_unit;
    if (temp < 35) return Icons.thermostat;
    return Icons.local_fire_department;
  }

  @override
  Widget build(BuildContext context) {
    final tempColor = _getTemperatureColor(_temperatura);
    final tempIcon = _getTemperatureIcon(_temperatura);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'TEMPERATURA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                tempIcon,
                size: 120,
                color: tempColor,
              ),
              const SizedBox(height: 32),
              const Text(
                'TEMPERATURA ACTUAL',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 32,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: tempColor.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                  border: Border.all(
                    color: tempColor,
                    width: 4,
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        strokeWidth: 6,
                      )
                    : _temperatura != null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _temperatura!.toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 72,
                                  fontWeight: FontWeight.bold,
                                  color: tempColor,
                                  height: 1.0,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '°C',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: tempColor.withOpacity(0.7),
                                  height: 2.0,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'ERROR',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade600,
                            ),
                          ),
              ),
              const SizedBox(height: 32),
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
                      Icons.update,
                      color: Colors.blue.shade700,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Actualización cada 2 segundos',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              if (_temperatura != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: tempColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getTemperatureStatus(_temperatura!),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: tempColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTemperatureStatus(double temp) {
    if (temp < 10) return 'MUY FRÍO';
    if (temp < 20) return 'FRÍO';
    if (temp < 30) return 'TEMPLADO';
    if (temp < 40) return 'CALIENTE';
    return 'MUY CALIENTE';
  }
}
