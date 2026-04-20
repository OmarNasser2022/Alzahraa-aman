

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedCounter extends StatelessWidget {
  final int value; // رقم الدور الحالي

  const AnimatedCounter({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500), // سرعة الحركة
      // طريقة حركة الرقم (يأتي من الأسفل للأعلى مع اختفاء الرقم القديم)
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      // المفتاح (Key) ضروري هنا ليفهم Flutter أن الرقم تغير فيقوم بالحركة
      child: Text(
        '$value',
        key: ValueKey<int>(value),
        style: TextStyle(
          fontSize: 80.sp,
          fontWeight: FontWeight.bold,
          color: value <= 3 ? Colors.orangeAccent : Colors.white, // تغيير اللون لو الدور قرب
          shadows: [
            Shadow(
              color: Colors.black26,
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
      ),
    );
  }
}