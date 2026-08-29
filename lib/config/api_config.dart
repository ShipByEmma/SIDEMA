class ApiConfig {
  static const String baseUrl = 'http://192.168.4.1';
  static const int port = 80;
  
  static const String activarEndpoint = '/activar';
  static const String desactivarEndpoint = '/desactivar';
  static const String vaciarEndpoint = '/vaciar';
  static const String detenerEndpoint = '/detener';
  static const String getTempEndpoint = '/gettemp';
  
  static String get fullUrl => '$baseUrl:$port';
  
  static String buildUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
}
