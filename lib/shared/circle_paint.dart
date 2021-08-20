import 'package:dsc_shop/shared/colors.dart';
import 'package:flutter/material.dart';

class Background extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _circle5(canvas, size);
    _circle3(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  void _circle3(Canvas canvas, Size size) {
    Gradient gradient1 = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        primaryColor,
        primaryColor,
      ],
      stops: [0.0, 0.3],
    );
    Paint paint1 = Paint();
    Rect rect1 = Rect.fromLTWH(0, 0, size.width, size.height);
    paint1.shader = gradient1.createShader(rect1);
    Offset offset1 =
    Offset(size.width - (size.width * 0.05), size.height * 0.1);
    Offset offset2 =
    Offset(size.width - (size.width * 0.05) - 3, size.height * 0.1 - 3);
    Path path = Path();
    Rect rect = Rect.fromCircle(center: offset2, radius: 175);
    path.addOval(rect);
    canvas.drawShadow(path, blackColor.withOpacity(0.4), 6, true);
    canvas.drawCircle(offset1, 170, paint1);
  }

  void _circle5(Canvas canvas, Size size) {
    Gradient gradient5 = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primaryColor,
        primaryColor,
      ],
      stops: [0.2, 0.4],
    );
    Paint paint5 = Paint();
    Rect rect7 = Rect.fromLTWH(0, 0, size.width, size.height);
    paint5.shader = gradient5.createShader(rect7);
    Offset offset7 = Offset(size.width * 0.1 - (size.width * 0.25),
        size.height - (size.height * 0.65));
    Offset offset8 = Offset(size.width * 0.1 - (size.width * 0.25) - 3,
        size.height - (size.height * 0.65) - 3);
    Path path4 = Path();
    Rect rect8 = Rect.fromCircle(center: offset8, radius: 163);
    path4.addOval(rect8);
    canvas.drawShadow(path4, blackColor.withOpacity(0.4), 8, true);
    canvas.drawCircle(offset7, 155, paint5);
  }
}

class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = whiteColor
    ..strokeWidth = 4
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}