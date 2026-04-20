
import 'dart:ui'; // ضروري لعمل تأثير التغبيش (Blur)
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart'; // استدعاء الألوان التي أنشأناها

class GlassCard extends StatelessWidget {
  final Widget child; // هذا هو المحتوى الذي سيكون داخل الكارت
  final double blur;  // درجة التغبيش

  const GlassCard({
    super.key, 
    required this.child, 
    this.blur = 10.0, // القيمة الافتراضية المطلوبة في المشروع
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // لعمل حواف دائرية للكارت
      borderRadius: BorderRadius.circular(20), 
      child: BackdropFilter(
        // هذا الجزء هو المسؤول عن تأثير الزجاج (Blur)
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.glassBackground, // اللون الشفاف من ملف الألوان
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.glassBorder, // إطار خفيف جداً
              width: 1.5,
            ),
          ),
          child: child, // عرض المحتوى الداخلي
        ),
      ),
    );
  }
}