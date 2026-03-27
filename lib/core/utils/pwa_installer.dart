export 'pwa_installer_stub.dart'
  if (dart.library.js_interop) 'pwa_installer_web.dart'
  if (dart.library.html) 'pwa_installer_web.dart';
