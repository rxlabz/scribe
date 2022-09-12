import 'package:flutter/painting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiver/iterables.dart';
import 'package:tuple/tuple.dart';

import '../scribe_theme.dart';
import '../svg.dart';
import 'editor_model.dart';

part 'character.freezed.dart';
part 'character.g.dart';

const defaultStrokeWidth = 60;

/// description of a character represented by a [symbol] ( glyphe? )
/// contains a list of [segments] to draw it,
/// and defines the duration of its drawing animation
/// Each segment is animated duting a partial interval of this [duration]
@freezed
class Character with _$Character {
  const Character._();

  const factory Character(
    String symbol, {
    required List<Segment> segments,
    @Default(4000) int duration,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  List<EditableSegment> get editableSegments =>
      segments.map<EditableSegment>((e) => EditableSegment.from(e)).toList();
}

/// group of characters sets
/// ex: Latin with 2 variants : uppercase & lowercase
@freezed
class CharacterSetGroup with _$CharacterSetGroup {
  const factory CharacterSetGroup({
    required String name,
    required List<CharacterSet> variants,
  }) = _CharacterSetGroup;

  factory CharacterSetGroup.fromJson(Map<String, dynamic> json) =>
      _$CharacterSetGroupFromJson(json);
}

@freezed
class CharacterSet with _$CharacterSet {
  const CharacterSet._();

  const factory CharacterSet({
    required String name,
    required List<Character> characters,
    @Default(defautlFontName) String fontName,
  }) = _CharacterSet;

  factory CharacterSet.fromJson(Map<String, dynamic> json) =>
      _$CharacterSetFromJson(json);

  Character operator [](int index) => characters[index];

  bool get isEmpty => characters.isEmpty;
}


@freezed
class Segment with _$Segment {
  const Segment._();

  const factory Segment({
    required String path,
    @JsonKey(fromJson: tuple2FromJson, toJson: tuple2ToJson)
        required Tuple2<double, double> interval,
  }) = _Segment;

  factory Segment.fromJson(Map<String, dynamic> json) =>
      _$SegmentFromJson(json);

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

  Segment copyWithEndPoint(Offset point) => Segment(
        path: path,
        interval: interval,
      );
}

Tuple2<double, double> tuple2FromJson(List<double> value) =>
    value.length == 2 ? Tuple2(value.first, value.last) : Tuple2(0, 1);

List<double> tuple2ToJson(Tuple2<double, double> value) =>
    [value.item1, value.item2];

