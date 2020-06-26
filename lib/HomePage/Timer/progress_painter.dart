import 'package:flutter/material.dart';
import 'dart:math';

class NeuProgressPainter extends CustomPainter {
  //
  Color defaultCircleColor;
  Color percentageCompletedCircleColor1;
  Color percentageCompletedCircleColor2;
  double completedPercentage;
  double circleWidth;

  NeuProgressPainter(
      {this.defaultCircleColor,
        this.percentageCompletedCircleColor1,
        this.percentageCompletedCircleColor2,
        this.completedPercentage,
        this.circleWidth});

  getPaint(Color color) {
    return Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint defaultCirclePaint = getPaint(defaultCircleColor);

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    Rect boundingSquare = Rect.fromCircle(center: center, radius: radius);

    paint(
        List<Color> colors,
        ) {
      final Gradient gradient = LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: colors,
      );

      return Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = circleWidth*1.5
        ..shader = gradient.createShader(boundingSquare);
    }

    canvas.drawCircle(center, radius, defaultCirclePaint);

    double arcAngle = 2 * pi * (completedPercentage / 100/60 );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      paint(
        [
          percentageCompletedCircleColor1,
          percentageCompletedCircleColor2,
        ],
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }
}