import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:scribe_lib/scribe_lib.dart';
import 'package:tuple/tuple.dart';

import 'painters.dart';

/// paint the animated segments
class AnimatedSegmentsPainter extends CustomPainter {
  final Character character;
  final List<double> animationProgressList;

  final double scale;

  final Color guideColor;
  final Color guidePenColor;

  AnimatedSegmentsPainter(
    this.character, {
    required this.animationProgressList,
    required this.scale,
    required this.guideColor,
    required this.guidePenColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(scale);
    _drawSegments(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void _drawSegments(Canvas canvas) {
    var count = 0;

    // paint each segment based on its progress
    for (final segment in character.segments) {
      final progress = animationProgressList[count];

      // skip  if the segment is not started
      if (progress == 0) continue;

      // segments curved points
      final curve = segment.pathPoints;

      final pathDivisions = pairCurvedPoints(curve);

      final numDivisions = pathDivisions.length;

      // génére un tableau avec "tous" les points intermediaire d'un segment
      // permet ensuite de trouver la position d'un point à l'instant [progress]
      final globalPoints = List.generate(
        numDivisions * 100,
        (index) => _getPonderateIntervalPosition(
          index / (numDivisions * 100),
          segments: pathDivisions,
          curve: curve,
        ),
      );
      if (globalPoints.isEmpty) return;

      final partialPoints =
          globalPoints.take((progress * numDivisions * 100).toInt());

      final path = _buildGuidePath(globalPoints, partialPoints);

      _drawGuidePath(canvas, path);
      _drawGuidePenCircle(partialPoints, canvas);

      count++;
    }
  }

  /* FIXME(rxlabz) refacto : should be a quadratic path
      between the starting point and a "middle point" on the curve
      cf. drawBezierFromPoints
      */
  /// draw a part of a curve by drawing lines between
  Path _buildGuidePath(
      List<Offset> globalPoints, Iterable<Offset> partialPoints) {
    final path = Path()..move(globalPoints.first);

    for (final p in partialPoints) {
      path.line(p);
    }
    return path;
  }

  void _drawGuidePath(Canvas canvas, Path path) =>
      canvas.drawPath(path, buildGuideStroke(guideColor));

  // draw the circle represent the pen
  void _drawGuidePenCircle(Iterable<Offset> partialPoints, Canvas canvas) {
    if (partialPoints.isNotEmpty) {
      canvas.drawCircle(partialPoints.last, 14, buildGuidePen(guidePenColor));
    }
  }

  /// returns a list of curvedPoints pair Tuple2<P,P>
  List<Tuple2<CurvePoint, CurvePoint>> pairCurvedPoints(
    List<CurvePoint> curve,
  ) =>
      enumerate(curve).fold<List<Tuple2<CurvePoint, CurvePoint>>>(
        <Tuple2<CurvePoint, CurvePoint>>[],
        (previousValue, element) {
          if (element.index == 0) return previousValue;

          return [
            ...previousValue,
            Tuple2(curve[element.index - 1], element.value),
          ];
        },
      );

  /// position dans le sous segment en cours
  /// en fonction de la progression globale et de la longueur du soussegment
  Offset _getPonderateIntervalPosition(
    double progress, {
    required List<Tuple2<CurvePoint, CurvePoint>> segments,
    required List<CurvePoint> curve,
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
}
