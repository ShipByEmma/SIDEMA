import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/temp_model.dart';

class Esp32Service {
  static final Esp32Service _instance = Esp32Service._internal();
  factory Esp32Service() => _instance;
  Esp32Service._internal();

  Future<bool> activar() async {
    try {
      final response = await http
          .get(Uri.parse(ApiConfig.buildUrl(ApiConfig.activarEndpoint)))
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      print('Error activar: $e');
      return false;
    }
  }

  Future<bool> desactivar() async {
    try {
      final response = await http
          .get(Uri.parse(ApiConfig.buildUrl(ApiConfig.desactivarEndpoint)))
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      print('Error desactivar: $e');
      return false;
    }
  }

  Future<bool> vaciar() async {
    try {
      final response = await http
          .get(Uri.parse(ApiConfig.buildUrl(ApiConfig.vaciarEndpoint)))
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      print('Error vaciar: $e');
      return false;
    }
  }

  Future<bool> detener() async {
    try {
      final response = await http
          .get(Uri.parse(ApiConfig.buildUrl(ApiConfig.detenerEndpoint)))
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      print('Error detener: $e');
      return false;
    }
  }

  Future<double?> getTemperatura() async {
    try {
      print('🌡️ Solicitando temperatura...');
      final response = await http
          .get(Uri.parse(ApiConfig.buildUrl(ApiConfig.getTempEndpoint)))
          .timeout(const Duration(seconds: 5));
      
      print('📊 Status Code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        print('📄 Respuesta JSON: ${response.body}');
        final jsonData = json.decode(response.body);
        final tempModel = TempModel.fromJson(jsonData);
        print('✅ Temperatura: ${tempModel.temperatura}°C');
        return tempModel.temperatura;
      }
      return null;
    } catch (e) {
      print('❌ Error getTemperatura: $e');
      print('📍 Tipo de error: ${e.runtimeType}');
      return null;
    }
  }

  Future<bool> checkConexion() async {
    try {
      print('🔍 Intentando conectar a: ${ApiConfig.buildUrl(ApiConfig.getTempEndpoint)}');
      final response = await http
          .get(Uri.parse(ApiConfig.buildUrl(ApiConfig.getTempEndpoint)))
          .timeout(const Duration(seconds: 3));
      print('✅ Respuesta recibida: ${response.statusCode}');
      print('📄 Body: ${response.body}');
      return response.statusCode == 200;
    } catch (e) {
      print('❌ Error de conexión: $e');
      print('📍 Tipo de error: ${e.runtimeType}');
      return false;
    }
  }
}
