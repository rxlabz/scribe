import 'package:flutter/material.dart';
import 'package:scribe_lib/scribe_lib.dart';

Paint buildLetterPen(Color color) => Paint()
  ..color = color
  ..strokeWidth = 35
  ..strokeCap = StrokeCap.round
  ..strokeJoin = StrokeJoin.round
  ..style = PaintingStyle.stroke;

Paint buildGuideStroke(Color color) => Paint()
  ..color = color
  ..strokeCap = StrokeCap.round
  ..strokeJoin = StrokeJoin.round
  ..strokeWidth = 20
  ..style = PaintingStyle.stroke;

Paint buildGuidePen(Color color) => Paint()
  ..color = color
  ..strokeWidth = 8
  ..style = PaintingStyle.stroke;

/// paint the letter model from [character] segments
class CharacterPainter extends CustomPainter {
  final Character character;

  final double scale;

  final Color textColor;

  CharacterPainter(
    this.character, {
    required this.scale,
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(scale);

    for (final segment in character.segments) {
      final path = buildPath(segment.path, width: 520, height: 520);
      canvas.drawPath(path, buildLetterPen(textColor));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// paint the user's line
class UserPainter extends CustomPainter {
  final List<List<Offset>> lines;

  final Paint pen = Paint()
    ..color = Colors.orange
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 20;

  final Paint successPen = Paint()
    ..color = Colors.limeAccent
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = 20;

  final bool succeed;

  UserPainter(this.lines, {required this.succeed});

  @override
  void paint(Canvas canvas, Size size) {
    for (final line in lines) {
      if (line.isEmpty) continue;

      final p = Path()..move(line.first);
      drawBezierFromPoints(points: line, path: p);

      canvas.drawPath(p, succeed ? successPen : pen);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/*
Offset interpolateCubic(double t, List<Offset> points) {
  final x = pow(1 - t, 3) * points[0].dx +
      pow(1 - t, 2) * 3 * t * points[1].dx +
      (1 - t) * 3 * pow(t, 2) * points[2].dx +
      pow(t, 3) * points[3].dx;

  final y = pow(1 - t, 3) * points[0].dy +
      pow(1 - t, 2) * 3 * t * points[1].dy +
      (1 - t) * 3 * pow(t, 2) * points[2].dy +
      pow(t, 3) * points[3].dy;

  return Offset(x, y);
}
*/

/*Offset interpolateCubic(double t, List<Offset> points) {
  final x = (2 * pow(t, 3) - 3 * t * t + 1) * points[0].dx +
      (pow(t, 3) - 2 * t * t + t) * points[1].dx +
      (-2 * pow(t, 3) + 3 * t * t) * points[2].dx +
      (pow(t, 3) - t * t) * points[3].dx;

  final y = (2 * pow(t, 3) - 3 * t * t + 1) * points[0].dy +
      (pow(t, 3) - 2 * t * t + t) * points[1].dy +
      (-2 * pow(t, 3) + 3 * t * t) * points[2].dy +
      (pow(t, 3) - t * t) * points[3].dy;

  return Offset(x, y);
}*/
