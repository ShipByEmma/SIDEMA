# 🦐 Descongelador de Camarones - App de Control

Aplicación Flutter para controlar un sistema de descongelado de camarones mediante ESP32.

## 🚀 Ejecución

```bash
flutter pub get
flutter run
```

## 📱 Características

### Pantalla de Inicio
- Indicador de conexión ESP32 en tiempo real
- Verificación automática cada 3 segundos

### Pantalla de Control
- **Iniciar Llenado**: Activa el sistema (llenado automático hasta 0.5 L)
- **Detener Sistema**: Apaga todo el sistema
- **Vaciar Tambo**: Inicia el vaciado
- **Detener Vaciado**: Detiene el proceso de vaciado

### Pantalla de Temperatura
- Monitoreo en tiempo real del sensor DS18B20
- Actualización automática cada 2 segundos
- Indicadores visuales según temperatura

## 🔧 Configuración ESP32

**Red WiFi:**
- SSID: `Descongelador`
- Password: `12345678`
- IP: `192.168.4.22`
- Puerto: `80`

**Endpoints:**
- `GET /activar` - Iniciar llenado
- `GET /desactivar` - Detener sistema
- `GET /vaciar` - Vaciar tambo
- `GET /detener` - Detener vaciado
- `GET /gettemp` - Obtener temperatura (JSON)

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                 # App principal
├── config/
│   └── api_config.dart       # Configuración de endpoints
├── services/
│   └── esp32_service.dart    # Servicio HTTP
├── models/
│   └── temp_model.dart       # Modelo de temperatura
├── screens/
│   ├── home_screen.dart      # Pantalla de inicio
│   ├── control_screen.dart   # Pantalla de control
│   └── temp_screen.dart      # Pantalla de temperatura
└── widgets/
    └── connection_status.dart # Widget de estado de conexión
```

## 🎨 Iconos de la App

Para generar los iconos de la aplicación:

```bash
flutter pub run flutter_launcher_icons
```

## 📦 Compilación

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle (Play Store)
```bash
flutter build appbundle --release
```

## 🛠️ Dependencias

- `http: ^1.2.0` - Peticiones HTTP al ESP32
- `flutter_launcher_icons: ^0.13.1` - Generación de iconos

## 📝 Notas

- La app requiere conexión a la red WiFi del ESP32
- Configurada para permitir tráfico HTTP (cleartext)
- Diseño industrial con interfaz intuitiva
