
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/app_colors.dart';
import 'screens/splash_screen.dart';
void main() {
  // لضمان استقرار التطبيق قبل التشغيل
  WidgetsFlutterBinding.ensureInitialized();
  
  // تغليف التطبيق بـ ProviderScope هو ما يعطيه "العقل" (Riverpod)
  runApp(const ProviderScope(child: MediVerseApp()));
}

class MediVerseApp extends StatelessWidget {
  const MediVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtilInit: أداة تجعل التطبيق متناسقاً على كل أحجام الشاشات
    return ScreenUtilInit(
      designSize: const Size(375, 812), // حجم الشاشة القياسي (iPhone)
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'MediVerse',
          debugShowCheckedModeBanner: false, // إخفاء علامة الـ Debug
          
          // إعدادات الثيم (Theme) - اخترنا الوضع المظلم كما في المتطلبات
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColors.darkBackground,
            primaryColor: AppColors.primaryBlue,
            fontFamily: 'Cairo', // سنقوم بإعداد الخط لاحقاً
          ),
          
          // سنبدأ حالياً بصفحة تجريبية حتى نصمم صفحة الدخول
          home: const SplashScreen(),
        );
      },
    );
  }
}

// صفحة مؤقتة فقط لنرى النتيجة
class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "أهلاً بك في MediVerse 🚀",
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}