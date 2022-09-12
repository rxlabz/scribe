import 'package:basics/basics.dart';
import 'package:flutter/painting.dart';
import 'package:quiver/iterables.dart';
import 'package:tuple/tuple.dart';

import '../svg.dart';
import 'editor_model.dart';

const defaultStrokeWidth = 60;

/// group of characters sets
/// ex: Latin with 2 variants : uppercase & lowercase
class CharacterSetGroup {
  final String name;
  final List<CharacterSet> variants;

  CharacterSetGroup({required this.name, required this.variants});
}

/// list of characters
class CharacterSet {
  final String name;
  final List<Character> characters;

  CharacterSet({required this.name, required this.characters});

  Character operator [](int index) => characters[index];
}

/// description of a character represented by a [symbol] ( glyphe? )
/// contains a list of [segments] to draw it,
/// and defines the duration of its drawing animation
/// Each segment is animated duting a partial interval of this [duration]
///
class Character {
  final String symbol;

  final List<Segment> segments;

  final int _durationInSec;

  Duration get duration => _durationInSec.seconds;

  const Character(
    this.symbol, {
    required this.segments,
    int duration = 4,
  }) : _durationInSec = duration;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'character': symbol,
        'duration': _durationInSec,
        'segments': segments.map((e) => e.toJson()).toList()
      };
}

/// a segment defined with a path and an [interval] during which
/// it is drawn
class Segment {
  final String path;

  /// interval pendant lequel se joue l'animation de ce segment
  final Tuple2<double, double> interval;

  List<SvgCommand<Offset>> get pathCommands => parseSvgPath(path);

  /// returns the list of [CurvePoint] of the segment
  /// as a bezier curve from commands
  ///
  List<CurvePoint> get pathPoints {
    final commands = pathCommands;

    final points = enumerate(pathCommands).fold<List<CurvePoint>>(
      [],
      (previousValue, cmd) {
        final points = cmd.value.points;

        if (cmd.value == commands.last) {
          return [
            ...previousValue,
            CurvePoint(
              points.length > 1 ? points[2] : points.first,
              anchorOut: points.length > 1 ? points[1] : points.first,
              anchorIn: points.length > 1 ? points[1] : points.first,
            ),
          ];
        }

        final nextPoints = commands[cmd.index + 1].points;

        if (cmd.value == commands.first) {
          return [
            CurvePoint(
              points[0],
              anchorIn: nextPoints[0],
              anchorOut: nextPoints[0],
            ),
          ];
        }

        return [
          ...previousValue,
          CurvePoint(
            points.length > 1 ? points[2] : points.first,
            anchorIn: points.length > 1 ? points[1] : points.first,
            anchorOut: nextPoints[0],
          ),
        ];
      },
    ).toList();

    return points;
  }

  const Segment({
    required this.path,
    required this.interval,
  });

  Segment copyWithEndPoint(Offset point) => Segment(
        path: path,
        interval: interval,
      );

  Map<String, dynamic> toJson() => {
        'path': path,
        'interval': [interval.item1, interval.item2],
      };
}
