import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:quiver/iterables.dart';
import 'package:tuple/tuple.dart';

import '../utils/curve_utils.dart';

const pointHandleWidth = 12.0;

const anchorHandleWidth = 8.0;

String curveToSVGPath(List<CurvePoint> curve) {
  if (curve.isEmpty) return '';

  var path =
      'M ${curve.first.offset.dx.toInt()} ${curve.first.offset.dy.toInt()}';

  for (final point in enumerate(curve)) {
    if (point.index == curve.length - 1) {
      continue;
    }

    final nextPoint = curve[point.index + 1];
    path = '$path C ${point.anchorOutX} ${point.anchorOutY} '
        '${nextPoint.anchorInX} ${nextPoint.anchorInY} '
        '${nextPoint.positionX} ${nextPoint.positionY}';
  }

  return path;
}

String lineToPath(List<CurvePoint> curve) {
  if (curve.isEmpty) return '';

  var path =
      'M ${curve.first.offset.dx.toInt()} ${curve.first.offset.dy.toInt()}';

  for (final point in enumerate(curve)) {
    if (point.index == curve.length - 1) {
      continue;
    }

    final nextPoint = curve[point.index + 1];
    path = '$path L ${nextPoint.positionX} ${nextPoint.positionY}';
  }

  return path;
}

enum Tool { line, cubic, pointer }

extension ToolHelpers on Tool {
  bool get isSelection => this == Tool.pointer;
}

const defaultInterval = Tuple2(0.0, 1.0);

class EditorSegment {
  /// duration in milliseconds
  final int duration;

  final Tuple2<double, double> _interval;
  Tuple2<double, double> get interval => _interval;

  final List<CurvePoint> _points;

  List<CurvePoint> get points => _points /*List.unmodifiable(_points)*/;

  /// maybe useless, but could be used for character dot drawing ex:"i" ?
  @Deprecated('à priori inutile')
  final Tool tool;

  bool get isEmpty => _points.isEmpty;

  bool get isNotEmpty => _points.isNotEmpty;

  String get svg {
    switch (tool) {
      case Tool.line:
        return lineToPath(_points);
      case Tool.cubic:
        return curveToSVGPath(_points);
      default:
        throw Exception('Invalid segment.tool : $tool');
    }
  }

  const EditorSegment._(
    this._points,
    this.tool, {
    Tuple2<double, double> interval = defaultInterval,
    this.duration = 3000,
  }) : _interval = interval;

  factory EditorSegment.create(Tool tool) {
    switch (tool) {
      case Tool.cubic:
        return EditorSegment.cubic([]);
      case Tool.line:
      default:
        return EditorSegment.line([]);
    }
  }

  const EditorSegment.line(
    this._points, {
    Tuple2<double, double> interval = defaultInterval,
    this.duration = 3000,
  })  : tool = Tool.line,
        _interval = interval;

  const EditorSegment.cubic(
    this._points, {
    Tuple2<double, double> interval = defaultInterval,
    this.duration = 3000,
  })  : tool = Tool.cubic,
        _interval = interval;

  void clear() => _points.clear();

  void add(CurvePoint p) => _points.add(p);

  void updateLast(CurvePoint p) => _points.last = p;

  void replace(CurvePoint oldValue, CurvePoint newValue) {
    final updatedCurve = _points.map((e) => e == oldValue ? newValue : e);
    _points.replaceRange(0, _points.length, updatedCurve);
  }

  List<CurvePoint> removeLast() => _points..removeLast();

  EditorSegment copyWithPoints(List<CurvePoint> points) =>
      EditorSegment._(points, tool, interval: _interval);

  EditorSegment copyWithInterval(double start, double end) =>
      EditorSegment._(_points, tool, interval: Tuple2(start, end));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditorSegment &&
          runtimeType == other.runtimeType &&
          listEquals(points, other.points) &&
          tool == other.tool;

  @override
  int get hashCode => points.hashCode ^ tool.hashCode;
}

extension on CurvePoint {
  int get positionX => offset.x;
  int get positionY => offset.y;

  int get anchorInX => anchorIn.x;
  int get anchorInY => anchorIn.y;

  int get anchorOutX => anchorOut.x;
  int get anchorOutY => anchorOut.y;
}

extension on IndexedValue<CurvePoint> {
  int get anchorInX => value.anchorIn.x;
  int get anchorInY => value.anchorIn.y;

  int get anchorOutX => value.anchorOut.x;
  int get anchorOutY => value.anchorOut.y;
}

extension on Offset {
  int get x => dx.toInt();
  int get y => dy.toInt();
}

class LinePoint extends Point<double> {
  LinePoint(Offset offset) : super(offset.dx, offset.dy);
}

class CurvePoint extends Point<double> {
  final Offset offset;

  final Offset anchorIn;

  final Offset anchorOut;

  CurvePoint(
    this.offset, {
    Offset? anchorIn,
    Offset? anchorOut,
  })  : anchorIn = anchorIn ?? offset,
        anchorOut = anchorOut ?? offset,
        super(offset.dx, offset.dy);

  CurvePoint copyWith({
    Offset? position,
    Offset? anchorIn,
    Offset? anchorOut,
  }) =>
      CurvePoint(
        position ?? this.offset,
        anchorIn: anchorIn ?? this.anchorIn,
        anchorOut: anchorOut ?? this.anchorOut,
      );

  ///
  double distance(CurvePoint point) {
    if (anchorIn == offset &&
        anchorOut == offset &&
        point.anchorIn == point.offset &&
        point.anchorOut == point.offset) {
      return (offset - point.offset).distance;
    }
    // diviser bezier en X segments et mesuerer les segments
    const numStep = 20;
    final curvePoints = List.generate(
      numStep,
      (index) => evaluateCubic(
        index / numStep,
        [offset, anchorOut, point.anchorIn, point.offset],
      ),
    );

    // calculate longueur total de la courbe décomposée/simplifiée
    // en [numStep] sous segments
    return enumerate(curvePoints).fold<List<double>>(<double>[],
        (previousValue, element) {
      if (element.index == 0) return previousValue;
      return [
        ...previousValue,
        (curvePoints[element.index - 1] - element.value).distance
      ];
    }).reduce((value, element) => element + value);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurvePoint &&
          runtimeType == other.runtimeType &&
          offset == other.offset &&
          anchorIn == other.anchorIn &&
          anchorOut == other.anchorOut;

  @override
  int get hashCode => offset.hashCode ^ anchorIn.hashCode ^ anchorOut.hashCode;
}
