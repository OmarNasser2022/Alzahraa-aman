
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/app_colors.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  // متغير للتحكم في حجم الزرار عند الضغط
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // عند الضغط لأسفل: صغّر الحجم قليلاً (تأثير ملموس)
      onTapDown: (_) => setState(() => _scale = 0.95),
      // عند رفع الإصبع: رجّع الحجم الطبيعي ونفذ الأمر
      onTapUp: (_) {
        setState(() => _scale = 1.0);
        widget.onPressed();
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100), // سرعة الحركة
        child: Container(
          width: double.infinity, // يأخذ عرض الشاشة بالكامل
          height: 55.h, // ارتفاع متناسق باستخدام ScreenUtil
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient, // التدرج اللوني الذي صنعناه
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: widget.isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    widget.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}