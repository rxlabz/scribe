import 'package:flutter/material.dart';
import 'package:scribe_lib/scribe_lib.dart';

import '../../../utils/canvas_utils.dart';

/// paint the (1) & (2) target markers
class NumerotedGuideMarkerPainter extends CustomPainter {
  final Segment segment;

  final List<Offset> userLine;

  final double scale;

  final Color textColor;

  final Paint defaultPen;

  final Paint validatedPen;

  NumerotedGuideMarkerPainter(
    this.segment,
    this.userLine, {
    required this.scale,
    required this.textColor,
    required Color backgroundColor,
    required Color activatedBackgroundColor,
  })  : defaultPen = Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.fill,
        validatedPen = Paint()
          ..color = activatedBackgroundColor
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) => _drawTargets(canvas);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void _drawTargets(Canvas canvas) {
    Offset startPoint = segment.pathCommands.first.points.first * scale;
    Offset endPoint = segment.pathCommands.last.points.last * scale;

    if ((startPoint - endPoint).distance < 30) {
      startPoint = Offset(startPoint.dx - 20, startPoint.dy);
      endPoint = Offset(endPoint.dx + 20, endPoint.dy);
    }

    if (userLine.isEmpty) {
      drawTarget(startPoint, canvas, 1);
      drawTarget(endPoint, canvas, 2);
      return;
    }

    // verify if the target has been touch by the user drawing gesture
    // if touched : draw a validated circle
    // else draw the numeroted target marker
    _isTargetValidated(startPoint, userLine.first)
        ? canvas.drawCircle(startPoint, 30, validatedPen)
        : drawTarget(startPoint, canvas, 1);

    _isTargetValidated(endPoint, userLine.last)
        ? canvas.drawCircle(endPoint, 30, validatedPen)
        : drawTarget(endPoint, canvas, 2);
  }

  void drawTarget(Offset targetPoint, Canvas canvas, int index) {
    canvas.drawCircle(targetPoint, 30, defaultPen);
    // if not validated draw the marker number
    drawMarkerText(canvas, targetPoint, index, textColor);
  }

  bool _isTargetValidated(Offset point, Offset target) =>
      (point - target).distance < tolerance;
}
