

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class WaveProgress extends StatefulWidget {
  final double progress; // نسبة التقدم من 0.0 إلى 1.0

  const WaveProgress({super.key, required this.progress});

  @override
  State<WaveProgress> createState() => _WaveProgressState();
}

class _WaveProgressState extends State<WaveProgress> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // محرك الحركة لجعل الموجة تتحرك يميناً ويساراً للأبد
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose(); // ضروري جداً لتوفير موارد الجهاز
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(double.infinity, 50),
          painter: WavePainter(
            progress: widget.progress,
            wavePhase: _controller.value * 2 * math.pi,
          ),
        );
      },
    );
  }
}

// الرسام المسؤول عن رسم شكل الموجة بالرياضيات
class WavePainter extends CustomPainter {
  final double progress;
  final double wavePhase;

  WavePainter({required this.progress, required this.wavePhase});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path();
    final yCenter = size.height * (1 - progress);

    path.moveTo(0, size.height);
    for (double x = 0; x <= size.width; x++) {
      // معادلة Sine Wave لرسم التموج
      final y = yCenter + math.sin(x * 0.05 + wavePhase) * 5;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}