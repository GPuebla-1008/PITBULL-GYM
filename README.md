# 🐕 PITBULL GYM — PWA

> Aplicación web progresiva (PWA) para gestión de gimnasio PITBULL GYM.  
> **URL:** https://pitbull-gym-100889.web.app  
> **Repositorio:** https://github.com/GPuebla-1008/PITBULL-GYM

---

## 📋 Changelog

Todas las versiones notables de este proyecto están documentadas aquí.  
Formato basado en [Keep a Changelog](https://keepachangelog.com/es/1.0.0/).

---

### [v1.4.0] — 2026-04-04 · `4515aba`
#### ✏️ Cambiado
- Logo principal reemplazado por la imagen oficial de PITBULL GYM (`pitbull_gym_new_logo`) en todos los assets del proyecto.
- Archivos actualizados: `assets/images/logo.png`, `web/favicon.png`, `web/icons/Icon-192.png`, `web/icons/Icon-512.png`, `web/icons/Icon-maskable-192.png`, `web/icons/Icon-maskable-512.png`.

---

### [v1.3.1] — 2026-04-04 · `c3117a9`
#### 🐛 Corregido
- Logo reemplazado por versión con fondo transparente (eliminado el fondo blanco/cuadriculado que se veía mal sobre la UI oscura).

---

### [v1.3.0] — 2026-04-04 · `b5f7992`
#### ✏️ Cambiado
- Logo actualizado al branding oficial de PITBULL GYM (perro pitbull con barra de pesas, colores dorado y negro) en todos los íconos de la app y el favicon del navegador.

---

### [v1.2.0] — 2026-04-04 · `c59c25d`
#### ✨ Agregado
- **Botón flotante de instalación PWA** con posición fija en esquina inferior derecha, animación bounce-in y efecto hover.
- **Android:** captura del evento `beforeinstallprompt` para disparar el instalador nativo del navegador (Chrome/Edge).
- **iOS/iPhone/iPad:** modal con instrucciones paso a paso (Safari → Compartir → Añadir a pantalla de inicio).
- **Overlay "Instalando…"** con spinner de carga animado que se activa al presionar el botón y se cierra al confirmar la instalación (`appinstalled` event).
- **Detección de modo standalone:** el botón se oculta automáticamente si la app ya está instalada.
- **Registro de Service Worker** (`flutter_service_worker.js`) con scope `/` para habilitar funcionalidad offline y criterios de instalabilidad.
- `manifest.json` actualizado con `start_url: "/"`, `scope: "/"`, `lang: "es-AR"`, `categories: ["fitness"]` e íconos con propósito `any` y `maskable` correctamente separados.

#### 🗑️ Eliminado
- Botón "Descargar App (Todos los Dispositivos)" de la UI de Flutter (reemplazado por el botón flotante HTML/JS).
- Imports problemáticos de `universal_html`, `url_launcher` y `foundation` que causaban errores de compilación cruzada.

---

### [v1.1.3] — 2026-03-27 · `62a6e77`
#### 🐛 Corregido
- Detección de plataforma iOS reforzada para incluir macOS como fallback.
- URL de descarga de APK apunta de nuevo a Firebase Hosting (evita error 404 de GitHub privado).

---

### [v1.1.2] — 2026-03-27 · `8646ee7`
#### 🐛 Corregido
- Descarga de APK migrada a GitHub Releases para evitar errores de memoria en Firebase Hosting.

---

### [v1.1.1] — 2026-03-27 · `1403f0a`
#### 🐛 Corregido
- Error 404 en descarga de APK desde GitHub. Descarga re-enrutada a Firebase Hosting.
- Verificación de plataforma iOS para evitar intento de descarga en dispositivos Apple.

---

### [v1.1.0] — 2026-03-27 · `4733712`
#### ✨ Agregado
- Pipeline CI/CD con **GitHub Actions** para deploy automático a **Firebase Hosting** en cada push a `main`.
- Workflow `firebase-hosting-merge.yml`: build `flutter build web --release` + deploy.
- Workflow `firebase-hosting-pull-request.yml`: preview channels para PRs.

---

### [v1.0.3] — 2026-03-27 · `996a6d1`
#### ✏️ Cambiado
- Botón de descarga refactorizado usando `url_launcher` para descarga directa nativa del APK, evitando diálogos manuales.

---

### [v1.0.2] — 2026-03-27 · `028b497`
#### ✏️ Cambiado
- Estrategia de descarga PWA cross-platform restaurada.

---

### [v1.0.1] — 2026-03-27 · `304184d`
#### 🐛 Corregido
- Permisos de escritura agregados en GitHub Actions para resolver error 403 en GitHub Releases.

---

### [v1.0.0] — 2026-03-27 · `ee75413`
#### 🎉 Lanzamiento inicial
- Primera versión de la aplicación PITBULL GYM como **Progressive Web App (PWA)** desplegada en Firebase Hosting.
- Pantalla de login con usuario/contraseña.
- Dashboard de gestión de gimnasio.
- Botón de descarga de APK para Android.
- Configuración inicial de `manifest.json` con ícono, colores y modo `standalone`.
- Soporte de íconos para iOS (`apple-touch-icon`) y Android.

---

## 🛠️ Stack Tecnológico

| Tecnología | Uso |
|---|---|
| **Flutter Web** | Framework principal de la app |
| **Firebase Hosting** | Hosting y distribución de la PWA |
| **GitHub Actions** | CI/CD — build y deploy automático |
| **Service Worker** | Soporte offline y criterios de instalación PWA |
| **Web Manifest** | Configuración de instalación PWA |

## 📱 Instalación

### Android (Chrome/Edge)
Al abrir la app en el navegador, aparece el **botón dorado "Instalar App"** en la esquina inferior derecha. Al presionarlo, el navegador muestra el instalador nativo.

### iPhone / iPad (Safari)
1. Abrí `pitbull-gym-100889.web.app` en **Safari**
2. Presioná el botón **"Instalar App"**
3. Seguí las instrucciones: **Compartir → Añadir a pantalla de inicio → Añadir**

---

## 🔗 Links

- 🌐 **App en producción:** https://pitbull-gym-100889.web.app
- 📦 **Repositorio:** https://github.com/GPuebla-1008/PITBULL-GYM
- 🤖 **GitHub Actions:** https://github.com/GPuebla-1008/PITBULL-GYM/actions
