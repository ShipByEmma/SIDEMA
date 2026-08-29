# 🧪 PRUEBA MANUAL DE CONEXIÓN

## Paso a paso para diagnosticar el problema

### 📱 PASO 1: Verificar WiFi

1. En tu celular Android, ve a: **Configuración → WiFi**
2. Busca la red: **Descongelador**
3. Conéctate con password: **12345678**

**✅ ¿Te conectaste?** Sí / No

---

### 🌐 PASO 2: Probar desde el Navegador

Con el celular conectado a "Descongelador":

#### Prueba A: Endpoint de temperatura
```
http://192.168.4.22/gettemp
```

**¿Qué muestra?** (Debería ser algo como `{"temperatura":25.50}`)

#### Prueba B: Endpoint activar
```
http://192.168.4.22/activar
```

**¿Qué muestra?** (Debería decir "Sistema ACTIVADO" o "Ya estaba ACTIVADO")

#### Prueba C: Verificar IP
```
http://192.168.4.22
```

**¿Qué muestra?** (Puede dar error 404, pero eso está bien - significa que el servidor responde)

---

### 📲 PASO 3: Información de la Conexión WiFi

En tu celular:

1. **Configuración → WiFi → Descongelador → Info/Detalles**

Anota:
- **IP asignada**: _________________
- **Gateway**: _________________
- **Máscara de red**: _________________

---

### 🖥️ PASO 4: Monitor Serial del ESP32

Si tienes el ESP32 conectado a la computadora:

1. Abre Arduino IDE
2. **Herramientas → Monitor Serial** (115200 baud)
3. Presiona el botón de RESET en el ESP32

**Copia aquí lo que aparece:**

```
[Pega aquí la salida del Monitor Serial]
```

---

### 📱 PASO 5: Ejecutar la App con Debug

```bash
cd C:\C_F\cam_arduino_flutter\gevel_shrimp
flutter run
```

Cuando la app se cargue, mira la consola. Aparecerán mensajes como:

```
🔍 Intentando conectar a: http://192.168.4.22/gettemp
❌ Error de conexión: [mensaje]
```

**Copia aquí los mensajes de error:**

```
[Pega aquí los errores de la consola]
```

---

## 🔍 ANÁLISIS DE RESULTADOS

### Si el navegador funciona pero la app no:

**Posibles causas:**
1. Problema con permisos HTTP en Android
2. Necesita CORS en el ESP32
3. Timeout muy corto

**Solución:**
- Revisa que `android:usesCleartextTraffic="true"` esté en AndroidManifest.xml
- Agrega CORS al ESP32 (ver AGREGAR_CORS.txt)

---

### Si ni el navegador ni la app funcionan:

**Posibles causas:**
1. El servidor web del ESP32 no inició
2. IP incorrecta
3. El ESP32 se reinició o trabó

**Solución:**
- Reinicia el ESP32
- Verifica el Monitor Serial
- Confirma que dice "Servidor web listo"

---

### Si el navegador da "No se puede conectar":

**Posibles causas:**
1. No estás conectado a la red "Descongelador"
2. El ESP32 no está encendido
3. Problema con el código del ESP32

**Solución:**
- Verifica que estés conectado a "Descongelador"
- Reinicia el ESP32
- Revisa el código del Arduino

---

## 📋 CHECKLIST FINAL

Marca lo que ya verificaste:

- [ ] El ESP32 enciende y muestra "Servidor web listo" en el Monitor Serial
- [ ] Aparece la red WiFi "Descongelador" en mi celular
- [ ] Me puedo conectar a la red "Descongelador"
- [ ] El navegador puede abrir http://192.168.4.22/gettemp
- [ ] La app tiene permiso de Internet
- [ ] El AndroidManifest.xml tiene `usesCleartextTraffic="true"`
- [ ] Ejecuté `flutter run` y revisé los errores en la consola

---

## 💬 DIME:

Con esta información podré identificar el problema exacto. Por favor responde:

1. ¿Funciona el navegador? (http://192.168.4.22/gettemp)
2. ¿Qué errores muestra la consola de Flutter?
3. ¿Qué dice el Monitor Serial del ESP32?

🦐
