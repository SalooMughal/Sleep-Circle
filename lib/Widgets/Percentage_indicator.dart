import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedCircularPercentage extends StatelessWidget {
  final double percentage1;
  final double percentage2;
  final double percentage3;
  final double percentage4;

  RoundedCircularPercentage({
    required this.percentage1,
    required this.percentage2,
    required this.percentage3,
    required this.percentage4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110.0.w,
      height: 110.0.h,
      child: CustomPaint(
        painter: RoundedCircularPercentagePainter(
          percentage1: percentage1,
          percentage2: percentage2,
          percentage3: percentage3,
          percentage4: percentage4,
        ),
      ),
    );
  }
}

class RoundedCircularPercentagePainter extends CustomPainter {
  final double percentage1;
  final double percentage2;
  final double percentage3;
  final double percentage4;

  RoundedCircularPercentagePainter({
    required this.percentage1,
    required this.percentage2,
    required this.percentage3,
    required this.percentage4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 12.0;
    final double radius = size.width / 2 - strokeWidth / 2;

    final Paint paint1 = Paint()
      ..color =Color(0x16636598)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // Rounded corners


    final Paint paint2 = Paint()
      ..color = Color(0xFFD9FFD8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // Rounded corners

    final Paint paint3 = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round; // Rounded corners

    final Paint paint4 = Paint()

      ..color = Color(0xFFC9AEFF)// Color for the fourth percentage
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // Rounded corners

    final Offset center = Offset(size.width / 2, size.height / 2);

    double arcAngle1 = 2 * math.pi * percentage1;
    double arcAngle2 = 2 * math.pi * percentage2;
    double arcAngle3 = 2 * math.pi * percentage3;
    double arcAngle4 = 2 * math.pi * percentage4;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      arcAngle1,
      false,
      paint1,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2 + arcAngle1,
      arcAngle2,
      false,
      paint2,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2 + arcAngle1 + arcAngle2,
      arcAngle3,
      false,
      paint3,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2 + arcAngle1 + arcAngle2 + arcAngle3,
      arcAngle4,
      false,
      paint4,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
