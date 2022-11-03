import 'package:flutter/material.dart';

class AppIconPainter extends CustomPainter {
  final double opacityOfLoaderStroke;

  AppIconPainter({this.opacityOfLoaderStroke = 0})
      : assert(opacityOfLoaderStroke >= 0 && opacityOfLoaderStroke <= 1);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01754386
      ..color = const Color(0xff222531).withOpacity(1.0);

    _paintBorder(paint0Stroke, canvas, size);

    Paint paintLoaderStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01754386
      ..color = Colors.blue.withOpacity(opacityOfLoaderStroke);

    _paintBorder(paintLoaderStroke, canvas, size);

    if (opacityOfLoaderStroke > 0) {
      Paint shadowPainter = Paint()
        ..strokeWidth = size.width * 0.01754386
        ..color = Colors.blue.withOpacity(opacityOfLoaderStroke)
        ..style = PaintingStyle.stroke
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);

      _paintBorder(shadowPainter, canvas, size);
    }

    Paint paintLetter = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xff363A4D).withOpacity(1.0);
    _paintLetter(paintLetter, canvas, size);

    Paint letterShadowPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue.withOpacity(opacityOfLoaderStroke);
    _paintLetter(letterShadowPaint, canvas, size);

    if (opacityOfLoaderStroke > 0) {
      Paint letterShadowPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.blue.withOpacity(opacityOfLoaderStroke)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      _paintLetter(letterShadowPaint, canvas, size);
    }
  }

  void _paintBorder(Paint paint, Canvas canvas, Size size) {
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
          size.width * 0.08771930,
          size.height * 0.08771930,
          size.width * 0.8245614,
          size.height * 0.8245614,
        ),
        bottomRight: Radius.circular(size.width * 0.06140351),
        bottomLeft: Radius.circular(size.width * 0.06140351),
        topLeft: Radius.circular(size.width * 0.06140351),
        topRight: Radius.circular(size.width * 0.06140351),
      ),
      paint,
    );
  }

  void _paintLetter(Paint paint, Canvas canvas, Size size) {
    Path path_1 = Path();
    path_1.moveTo(size.width * 0.2994417, size.height * 0.3767943);
    path_1.lineTo(size.width * 0.3584531, size.height * 0.3767943);
    path_1.lineTo(size.width * 0.4972105, size.height * 0.7157105);
    path_1.lineTo(size.width * 0.5019956, size.height * 0.7157105);
    path_1.lineTo(size.width * 0.6407500, size.height * 0.3767943);
    path_1.lineTo(size.width * 0.6997588, size.height * 0.3767943);
    path_1.lineTo(size.width * 0.6997588, size.height * 0.7850877);
    path_1.lineTo(size.width * 0.6535088, size.height * 0.7850877);
    path_1.lineTo(size.width * 0.6535088, size.height * 0.4748816);
    path_1.lineTo(size.width * 0.6495219, size.height * 0.4748816);
    path_1.lineTo(size.width * 0.5219298, size.height * 0.7850877);
    path_1.lineTo(size.width * 0.4772719, size.height * 0.7850877);
    path_1.lineTo(size.width * 0.3496811, size.height * 0.4748816);
    path_1.lineTo(size.width * 0.3456939, size.height * 0.4748816);
    path_1.lineTo(size.width * 0.3456939, size.height * 0.7850877);
    path_1.lineTo(size.width * 0.2994417, size.height * 0.7850877);
    path_1.lineTo(size.width * 0.2994417, size.height * 0.3767943);
    path_1.close();

    canvas.drawPath(path_1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
