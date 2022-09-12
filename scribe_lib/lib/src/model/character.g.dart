// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Character _$$_CharacterFromJson(Map<String, dynamic> json) => _$_Character(
      json['symbol'] as String,
      segments: (json['segments'] as List<dynamic>)
          .map((e) => Segment.fromJson(e as Map<String, dynamic>))
          .toList(),
      duration: json['duration'] as int? ?? 4000,
    );

Map<String, dynamic> _$$_CharacterToJson(_$_Character instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'segments': instance.segments,
      'duration': instance.duration,
    };

_$_CharacterSetGroup _$$_CharacterSetGroupFromJson(Map<String, dynamic> json) =>
    _$_CharacterSetGroup(
      name: json['name'] as String,
      variants: (json['variants'] as List<dynamic>)
          .map((e) => CharacterSet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CharacterSetGroupToJson(
        _$_CharacterSetGroup instance) =>
    <String, dynamic>{
      'name': instance.name,
      'variants': instance.variants,
    };

_$_CharacterSet _$$_CharacterSetFromJson(Map<String, dynamic> json) =>
    _$_CharacterSet(
      name: json['name'] as String,
      characters: (json['characters'] as List<dynamic>)
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList(),
      fontName: json['fontName'] as String? ?? defautlFontName,
    );

Map<String, dynamic> _$$_CharacterSetToJson(_$_CharacterSet instance) =>
    <String, dynamic>{
      'name': instance.name,
      'characters': instance.characters,
      'fontName': instance.fontName,
    };

_$_Segment _$$_SegmentFromJson(Map<String, dynamic> json) => _$_Segment(
      path: json['path'] as String,
      interval: tuple2FromJson(json['interval'] as List<double>),
    );

Map<String, dynamic> _$$_SegmentToJson(_$_Segment instance) =>
    <String, dynamic>{
      'path': instance.path,
      'interval': tuple2ToJson(instance.interval),
    };
