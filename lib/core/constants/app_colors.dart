

import 'package:flutter/material.dart';

class AppColors {
  // الألوان الأساسية المطلوبة في المشروع
  // 0xFF تعني أن اللون معتم تماماً، ثم نكتب كود اللون
  static const Color primaryBlue = Color(0xFF2563EB); 
  static const Color primaryBlueDark = Color(0xFF1E40AF);
  static const Color accentGreen = Color(0xFF10B981);

  // التدرجات اللونية (Gradients) للأزرار
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryBlueDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [accentGreen, Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ألوان وضع الظلام (Dark Mode)
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  
  // ألوان التأثير الزجاجي (Glassmorphism)
  static Color glassBackground = Colors.white.withOpacity(0.15);
  static Color glassBorder = Colors.white.withOpacity(0.3);
}