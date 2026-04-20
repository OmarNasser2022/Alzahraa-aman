
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // الانتقال لصفحة تسجيل الدخول بعد 3 ثوانٍ
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية بيضاء لتبرز ألوان اللوجو
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // تكبير اللوجو ليكون واضحاً ومتناسقاً مع الصفحة
            Image.asset(
              'assets/images/logo.png',
              width: 280.w, // حجم أكبر ليملأ الشاشة بوضوح
              fit: BoxFit.contain,
              // في حال وجود خطأ في المسار يظهر نص بديل
              errorBuilder: (context, error, stackTrace) => 
                Text("MediVerse", style: TextStyle(fontSize: 30.sp, color: Colors.blue, fontWeight: FontWeight.bold)),
            ),
            
            SizedBox(height: 30.h),
            
            // مؤشر تحميل بسيط يعطي لمسة احترافية
            const CircularProgressIndicator(
              color: Color(0xFF1E40AF), // اللون الكحلي المتناسق مع هويتك
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}