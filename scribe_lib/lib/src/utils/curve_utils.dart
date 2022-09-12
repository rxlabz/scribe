import 'dart:math';
import 'dart:ui';

import 'package:tuple/tuple.dart';

/// Path shorcuts allowing use Offset instead of (x,y) params
extension Shortcuts on Path {
  void move(Offset o) => moveTo(o.dx, o.dy);

  void line(Offset o) => lineTo(o.dx, o.dy);

  void cubic(Tuple3<Offset, Offset, Offset> points) => cubicTo(
        points.item1.dx,
        points.item1.dy,
        points.item2.dx,
        points.item2.dy,
        points.item3.dx,
        points.item3.dy,
      );
}

///
Offset evaluateQuad(double t, List<Offset> points) {
  final x = pow(1 - t, 2) * points.first.dx +
      (1 - t) * 2 * t * points[1].dx +
      t * t * points.last.dx;
  final y = pow(1 - t, 2) * points.first.dy +
      (1 - t) * 2 * t * points[1].dy +
      t * t * points.last.dy;
  return Offset(x, y);
}

Offset evaluateCubic(double t, List<Offset> points) {
  final x = pow(1 - t, 3) * points[0].dx +
      pow(1 - t, 2) * 3 * t * points[1].dx +
      (1 - t) * 3 * t * t * points[2].dx +
      pow(t, 3) * points[3].dx;

  final y = pow(1 - t, 3) * points[0].dy +
      pow(1 - t, 2) * 3 * t * points[1].dy +
      (1 - t) * 3 * t * t * points[2].dy +
      pow(t, 3) * points[3].dy;

  return Offset(x, y);
}

/// draw cubic bezier from list of points to smooth the simplified
/// user drawing
void drawBezierFromPoints({required List<Offset> points, required Path path}) =>
    bezierPointsFromPoints(points).forEach((p) => path.cubic(p));

List<Tuple3<Offset, Offset, Offset>> bezierPointsFromPoints(
  List<Offset> points,
) {
  List<Tuple3<Offset, Offset, Offset>> curvePoints = [];
  for (var i = 0; i < points.length - 1; i++) {
    final p0 = (i > 0) ? points[i - 1] : points[0];
    final p1 = points[i];
    final p2 = points[i + 1];
    final p3 = i != points.length - 2 ? points[i + 2] : p2;

    final cp1x = p1.dx + (p2.dx - p0.dx) / 6 /** t*/;
    final cp1y = p1.dy + (p2.dy - p0.dy) / 6 /** t*/;

    final cp2x = p2.dx - (p3.dx - p1.dx) / 6 /** t*/;
    final cp2y = p2.dy - (p3.dy - p1.dy) / 6 /** t*/;

    curvePoints.add(
      Tuple3(Offset(cp1x, cp1y), Offset(cp2x, cp2y), Offset(p2.dx, p2.dy)),
    );
  }

  return curvePoints;
}
