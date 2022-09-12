import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:scribe_lib/scribe_lib.dart';
import 'package:tuple/tuple.dart';

final fill1 = Paint()
  ..color = Colors.red
  ..style = PaintingStyle.fill;

final fill2 = Paint()
  ..color = Colors.blue
  ..style = PaintingStyle.fill;

final highlight = Paint()
  ..color = Colors.amber
  ..strokeWidth = 8
  ..style = PaintingStyle.stroke;

final highlight2 = Paint()
  ..color = Colors.amber.withOpacity(.8)
  ..strokeWidth = 20
  ..style = PaintingStyle.stroke;

final stroke0 = Paint()
  ..color = Colors.grey.shade400
  ..strokeWidth = 4
  ..style = PaintingStyle.stroke;

final stroke1 = Paint()
  ..color = Colors.cyan
  ..strokeWidth = 4
  ..style = PaintingStyle.stroke;

final stroke2 = Paint()
  ..color = Colors.grey
  ..style = PaintingStyle.stroke;

/// selected/edited segment painter
class CurvePainter extends CustomPainter {
  final CurvePoint? currentPoint;

  final List<CurvePoint> curve;

  CurvePainter(this.currentPoint, this.curve);

  @override
  void paint(Canvas canvas, Size size) {
    if (curve.isNotEmpty) {
      var count = 0;
      while (curve.length > count + 1) {
        final path = Path()..move(curve[count].offset);

        if (curve.length > 1) {
          path.cubicTo(
            curve[count].anchorOut.dx,
            curve[count].anchorOut.dy,
            curve[count + 1].anchorIn.dx,
            curve[count + 1].anchorIn.dy,
            curve[count + 1].offset.dx,
            curve[count + 1].offset.dy,
          );
        }
        canvas.drawPath(path, stroke1);
        count++;
      }
    }

    for (final p in curve) {
      //drawCurrentPoint(canvas, p);
      canvas.drawCircle(p.offset, 4, fill1);
    }

    if (currentPoint != null) drawCurrentPoint(canvas, currentPoint!);
  }

  @override
  bool shouldRepaint(covariant CurvePainter oldDelegate) =>
      listEquals(curve, oldDelegate.curve);

  void drawCurrentPoint(Canvas canvas, CurvePoint point) {
    canvas.drawCircle(point.offset, 6, fill1);
    if (point.anchorIn != point.offset) {
      canvas.drawCircle(point.anchorIn, 4, fill2);
      canvas.drawLine(point.offset, point.anchorIn, stroke2);
    }
    if (point.anchorIn != point.offset) {
      canvas.drawCircle(point.anchorOut, 4, fill2);
      canvas.drawLine(point.offset, point.anchorOut, stroke2);
    }
  }
}

/// not selected segment painter
class CurvesPainter extends CustomPainter {
  final Iterable<List<CurvePoint>> curves;

  CurvesPainter(this.curves);

  @override
  void paint(Canvas canvas, Size size) {
    for (final curve in curves) {
      if (curve.isNotEmpty) {
        var count = 0;
        while (curve.length > count + 1) {
          final path = Path()..move(curve[count].offset);

          if (curve.length > 1) {
            path.cubicTo(
              curve[count].anchorOut.dx,
              curve[count].anchorOut.dy,
              curve[count + 1].anchorIn.dx,
              curve[count + 1].anchorIn.dy,
              curve[count + 1].offset.dx,
              curve[count + 1].offset.dy,
            );
          }
          canvas.drawPath(path, stroke0);
          count++;
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CurvesPainter oldDelegate) =>
      listEquals(curves.toList(), oldDelegate.curves.toList());

  void drawCurrentPoint(Canvas canvas, CurvePoint point) {
    canvas.drawCircle(point.offset, 6, fill1);
    if (point.anchorIn != point.offset) {
      canvas.drawCircle(point.anchorIn, 4, fill2);
      canvas.drawLine(point.offset, point.anchorIn, stroke2);
    }
    if (point.anchorIn != point.offset) {
      canvas.drawCircle(point.anchorOut, 4, fill2);
      canvas.drawLine(point.offset, point.anchorOut, stroke2);
    }
  }
}

class AnimatedSegmentsPainter extends CustomPainter {
  final List<CurvePoint> curve;

  final double progress;

  AnimatedSegmentsPainter(this.curve, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (curve.length >= 2 && progress > 0) {
      final pathSegments =
          enumerate(curve).fold<List<Tuple2<CurvePoint, CurvePoint>>>(
        <Tuple2<CurvePoint, CurvePoint>>[],
        (previousValue, element) {
          if (element.index == 0) return previousValue;

          return [
            ...previousValue,
            Tuple2(curve[element.index - 1], element.value)
          ];
        },
      );

      final numSegments = pathSegments.length;

      // partial curve
      // tableau qui doit contenir la liste des 100 positions de la courbe entière
      final globalPoints = List.generate(
        numSegments * 100,
        (index) => _getScaledIntervalPosition(
          index / (numSegments * 100),
          segments: pathSegments,
        ),
      );

      final path = Path()..move(globalPoints.first);

      final partialPoints =
          globalPoints.take((progress * numSegments * 100).toInt());

      for (final p in partialPoints) {
        path.line(p);
      }
      canvas.drawPath(path, highlight2);
      if (partialPoints.isNotEmpty) {
        canvas.drawCircle(partialPoints.last, 14, highlight);
      }
    }
  }

  /// position dans le sous segment en cours
  /// en fonction de la progression globale et de la longueur du soussegment
  Offset _getScaledIntervalPosition(
    double progress, {
    required List<Tuple2<CurvePoint, CurvePoint>> segments,
  }) {
    // calcul du ratio distance de chaque segment
    final segmentDistances =
        segments.map((element) => element.item1.distance(element.item2));

    final curveDistance = segmentDistances.fold<double>(
      0,
      (previousValue, element) => previousValue + element,
    );

    final segmentPonderations =
        segmentDistances.map((e) => e / curveDistance).toList();

    final cumulatedSegmentPonderations =
        segmentPonderations.fold<List<double>>([], (previousValue, element) {
      if (previousValue.isEmpty) return [element];

      return [...previousValue, element + previousValue.last];
    });
    final currentSegmentIndex = enumerate(cumulatedSegmentPonderations)
        .firstWhere((element) => progress <= element.value)
        .index;

    final start = currentSegmentIndex;
    final end = currentSegmentIndex + 1;

    final segmentProgress = (progress -
            (currentSegmentIndex == 0
                ? 0
                : cumulatedSegmentPonderations[currentSegmentIndex - 1])) *
        (1 / segmentPonderations[currentSegmentIndex]);

    final bezierPoint = [
      curve[start].offset,
      curve[start].anchorOut,
      curve[end].anchorIn,
      curve[end].offset,
    ];

    return evaluateCubic(math.min(segmentProgress, 1.0), bezierPoint);
  }

  @override
  bool shouldRepaint(covariant AnimatedSegmentsPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
