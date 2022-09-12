import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// build a Flutter canvas path from a svg path string
Path buildPath(
  String svgPath, {
  required double width,
  required double height,
  double scale = 1,
}) {
  final cmds = parseSvgPath(svgPath);

  final path = Path();

  for (final c in cmds) {
    switch (c.type) {
      case SvgCommandType.line:
        final pt = c.points.first.scale(scale, scale);
        path.lineTo(pt.dx.floorToDouble(), pt.dy.floorToDouble());
        break;
      case SvgCommandType.move:
        final pt = c.points.first.scale(scale, scale);
        path.moveTo(pt.dx.floorToDouble(), pt.dy.floorToDouble());
        break;
      case SvgCommandType.quad:
        final pt1 = c.points.first.scale(scale, scale);
        final pt2 = c.points.last.scale(scale, scale);
        path.quadraticBezierTo(pt1.dx.floorToDouble(), pt1.dy.floorToDouble(),
            pt2.dx.floorToDouble(), pt2.dy.floorToDouble());
        break;
      case SvgCommandType.close:
        final pt = cmds.first.points.first.scale(scale, scale);
        path.lineTo(pt.dx.floorToDouble(), pt.dy.floorToDouble());
        path.close();
        break;
      case SvgCommandType.cubic:
        final anchor1 = c.points[0].scale(scale, scale);
        final pt2 = c.points[1].scale(scale, scale);
        final pt3 = c.points[2].scale(scale, scale);
        path.cubicTo(
          anchor1.dx.floorToDouble(),
          anchor1.dy.floorToDouble(),
          pt2.dx.floorToDouble(),
          pt2.dy.floorToDouble(),
          pt3.dx.floorToDouble(),
          pt3.dy.floorToDouble(),
        );
        break;
    }
  }

  return path;
}

/// minimalistic SVG parsing
final RegExp svgRegexp = RegExp(r'([MLQC]) ((-?\d+\.?\d*(?:$|\s)){1,6})');

/// parse a svg path and return a list of [SvgCommand]
List<SvgCommand<Offset>> parseSvgPath(String data) {
  final matches = svgRegexp.allMatches(data);

  // map a Svg regexp match to a [SvgCommand]
  SvgCommand<Offset> svgSegmentMatchToCommand(Match m) {
    final type = getSvgCommandType(m.group(1)!);
    final points = getSvgCommandPoints(m.group(2)!);
    return SvgCommand<Offset>(type!, points);
  }

  return matches.map(svgSegmentMatchToCommand).toList();
}

/// represent a path drawing step
/// defined by a [SvgCommandType] [type] and a list of [points]
@immutable
class SvgCommand<T> {
  final SvgCommandType type;

  final List<T> points;

  const SvgCommand(this.type, this.points);

  @override
  String toString() {
    return 'SvgCommand{type: $type, points: $points}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SvgCommand &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          listEquals(points, other.points);

  @override
  int get hashCode => type.hashCode ^ points.hashCode;
}

enum SvgCommandType {
  line(symbol: 'L'),
  move(symbol: 'M'),
  quad(symbol: 'Q'),
  cubic(symbol: 'C'),
  close(symbol: 'Z');

  final String symbol;

  const SvgCommandType({required this.symbol});
}

SvgCommandType? getSvgCommandType(String symbol) {
  try {
    return SvgCommandType.values
        .firstWhere((element) => element.symbol == symbol);
  } catch (err) {
    return null;
  }
}

/// return the offsets of a svg segment
///
/// example :
///   - L 100 200 returns [Offset(100.0,200.0)]
/// Warning : can't be used for HV
List<Offset> getSvgCommandPoints(String pointsString) {
  final values = pointsString.trim().split(' ');
  var points = <Offset>[];

  points.addAll(
    List.generate(
      values.length ~/ 2,
      (index) => Offset(
        double.parse(values[index * 2].toString()),
        double.parse(values[index * 2 + 1].toString()),
      ),
    ),
  );
  return points;
}
