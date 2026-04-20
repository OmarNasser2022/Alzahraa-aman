

import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  // التأكد هل الجهاز يدعم البصمة أصلاً؟
  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    return canAuthenticate;
  }

  // تنفيذ عملية التوثيق بالبصمة
  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'من فضلك استخدم البصمة لتسجيل الدخول',
        options: const AuthenticationOptions(
          biometricOnly: true, // استخدام البصمة فقط وليس الرقم السري
          stickyAuth: true,    // بقاء التوثيق نشطاً إذا خرج المستخدم ورجع
        ),
      );
    } catch (e) {
      print("خطأ في البصمة: $e");
      return false;
    }
  }
}