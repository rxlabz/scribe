// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'character.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Character _$CharacterFromJson(Map<String, dynamic> json) {
  return _Character.fromJson(json);
}

/// @nodoc
mixin _$Character {
  String get symbol => throw _privateConstructorUsedError;
  List<Segment> get segments => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterCopyWith<Character> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterCopyWith<$Res> {
  factory $CharacterCopyWith(Character value, $Res Function(Character) then) =
      _$CharacterCopyWithImpl<$Res>;
  $Res call({String symbol, List<Segment> segments, int duration});
}

/// @nodoc
class _$CharacterCopyWithImpl<$Res> implements $CharacterCopyWith<$Res> {
  _$CharacterCopyWithImpl(this._value, this._then);

  final Character _value;
  // ignore: unused_field
  final $Res Function(Character) _then;

  @override
  $Res call({
    Object? symbol = freezed,
    Object? segments = freezed,
    Object? duration = freezed,
  }) {
    return _then(_value.copyWith(
      symbol: symbol == freezed
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      segments: segments == freezed
          ? _value.segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<Segment>,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_CharacterCopyWith<$Res> implements $CharacterCopyWith<$Res> {
  factory _$$_CharacterCopyWith(
          _$_Character value, $Res Function(_$_Character) then) =
      __$$_CharacterCopyWithImpl<$Res>;
  @override
  $Res call({String symbol, List<Segment> segments, int duration});
}

/// @nodoc
class __$$_CharacterCopyWithImpl<$Res> extends _$CharacterCopyWithImpl<$Res>
    implements _$$_CharacterCopyWith<$Res> {
  __$$_CharacterCopyWithImpl(
      _$_Character _value, $Res Function(_$_Character) _then)
      : super(_value, (v) => _then(v as _$_Character));

  @override
  _$_Character get _value => super._value as _$_Character;

  @override
  $Res call({
    Object? symbol = freezed,
    Object? segments = freezed,
    Object? duration = freezed,
  }) {
    return _then(_$_Character(
      symbol == freezed
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      segments: segments == freezed
          ? _value._segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<Segment>,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Character extends _Character {
  const _$_Character(this.symbol,
      {required final List<Segment> segments, this.duration = 4000})
      : _segments = segments,
        super._();

  factory _$_Character.fromJson(Map<String, dynamic> json) =>
      _$$_CharacterFromJson(json);

  @override
  final String symbol;
  final List<Segment> _segments;
  @override
  List<Segment> get segments {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_segments);
  }

  @override
  @JsonKey()
  final int duration;

  @override
  String toString() {
    return 'Character(symbol: $symbol, segments: $segments, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Character &&
            const DeepCollectionEquality().equals(other.symbol, symbol) &&
            const DeepCollectionEquality().equals(other._segments, _segments) &&
            const DeepCollectionEquality().equals(other.duration, duration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(symbol),
      const DeepCollectionEquality().hash(_segments),
      const DeepCollectionEquality().hash(duration));

  @JsonKey(ignore: true)
  @override
  _$$_CharacterCopyWith<_$_Character> get copyWith =>
      __$$_CharacterCopyWithImpl<_$_Character>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CharacterToJson(
      this,
    );
  }
}

abstract class _Character extends Character {
  const factory _Character(final String symbol,
      {required final List<Segment> segments,
      final int duration}) = _$_Character;
  const _Character._() : super._();

  factory _Character.fromJson(Map<String, dynamic> json) =
      _$_Character.fromJson;

  @override
  String get symbol;
  @override
  List<Segment> get segments;
  @override
  int get duration;
  @override
  @JsonKey(ignore: true)
  _$$_CharacterCopyWith<_$_Character> get copyWith =>
      throw _privateConstructorUsedError;
}

CharacterSetGroup _$CharacterSetGroupFromJson(Map<String, dynamic> json) {
  return _CharacterSetGroup.fromJson(json);
}

/// @nodoc
mixin _$CharacterSetGroup {
  String get name => throw _privateConstructorUsedError;
  List<CharacterSet> get variants => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterSetGroupCopyWith<CharacterSetGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterSetGroupCopyWith<$Res> {
  factory $CharacterSetGroupCopyWith(
          CharacterSetGroup value, $Res Function(CharacterSetGroup) then) =
      _$CharacterSetGroupCopyWithImpl<$Res>;
  $Res call({String name, List<CharacterSet> variants});
}

/// @nodoc
class _$CharacterSetGroupCopyWithImpl<$Res>
    implements $CharacterSetGroupCopyWith<$Res> {
  _$CharacterSetGroupCopyWithImpl(this._value, this._then);

  final CharacterSetGroup _value;
  // ignore: unused_field
  final $Res Function(CharacterSetGroup) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? variants = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      variants: variants == freezed
          ? _value.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<CharacterSet>,
    ));
  }
}

/// @nodoc
abstract class _$$_CharacterSetGroupCopyWith<$Res>
    implements $CharacterSetGroupCopyWith<$Res> {
  factory _$$_CharacterSetGroupCopyWith(_$_CharacterSetGroup value,
          $Res Function(_$_CharacterSetGroup) then) =
      __$$_CharacterSetGroupCopyWithImpl<$Res>;
  @override
  $Res call({String name, List<CharacterSet> variants});
}

/// @nodoc
class __$$_CharacterSetGroupCopyWithImpl<$Res>
    extends _$CharacterSetGroupCopyWithImpl<$Res>
    implements _$$_CharacterSetGroupCopyWith<$Res> {
  __$$_CharacterSetGroupCopyWithImpl(
      _$_CharacterSetGroup _value, $Res Function(_$_CharacterSetGroup) _then)
      : super(_value, (v) => _then(v as _$_CharacterSetGroup));

  @override
  _$_CharacterSetGroup get _value => super._value as _$_CharacterSetGroup;

  @override
  $Res call({
    Object? name = freezed,
    Object? variants = freezed,
  }) {
    return _then(_$_CharacterSetGroup(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      variants: variants == freezed
          ? _value._variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<CharacterSet>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CharacterSetGroup implements _CharacterSetGroup {
  const _$_CharacterSetGroup(
      {required this.name, required final List<CharacterSet> variants})
      : _variants = variants;

  factory _$_CharacterSetGroup.fromJson(Map<String, dynamic> json) =>
      _$$_CharacterSetGroupFromJson(json);

  @override
  final String name;
  final List<CharacterSet> _variants;
  @override
  List<CharacterSet> get variants {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variants);
  }

  @override
  String toString() {
    return 'CharacterSetGroup(name: $name, variants: $variants)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CharacterSetGroup &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other._variants, _variants));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(_variants));

  @JsonKey(ignore: true)
  @override
  _$$_CharacterSetGroupCopyWith<_$_CharacterSetGroup> get copyWith =>
      __$$_CharacterSetGroupCopyWithImpl<_$_CharacterSetGroup>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CharacterSetGroupToJson(
      this,
    );
  }
}

abstract class _CharacterSetGroup implements CharacterSetGroup {
  const factory _CharacterSetGroup(
      {required final String name,
      required final List<CharacterSet> variants}) = _$_CharacterSetGroup;

  factory _CharacterSetGroup.fromJson(Map<String, dynamic> json) =
      _$_CharacterSetGroup.fromJson;

  @override
  String get name;
  @override
  List<CharacterSet> get variants;
  @override
  @JsonKey(ignore: true)
  _$$_CharacterSetGroupCopyWith<_$_CharacterSetGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

CharacterSet _$CharacterSetFromJson(Map<String, dynamic> json) {
  return _CharacterSet.fromJson(json);
}

/// @nodoc
mixin _$CharacterSet {
  String get name => throw _privateConstructorUsedError;
  List<Character> get characters => throw _privateConstructorUsedError;
  String get fontName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterSetCopyWith<CharacterSet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterSetCopyWith<$Res> {
  factory $CharacterSetCopyWith(
          CharacterSet value, $Res Function(CharacterSet) then) =
      _$CharacterSetCopyWithImpl<$Res>;
  $Res call({String name, List<Character> characters, String fontName});
}

/// @nodoc
class _$CharacterSetCopyWithImpl<$Res> implements $CharacterSetCopyWith<$Res> {
  _$CharacterSetCopyWithImpl(this._value, this._then);

  final CharacterSet _value;
  // ignore: unused_field
  final $Res Function(CharacterSet) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? characters = freezed,
    Object? fontName = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      characters: characters == freezed
          ? _value.characters
          : characters // ignore: cast_nullable_to_non_nullable
              as List<Character>,
      fontName: fontName == freezed
          ? _value.fontName
          : fontName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_CharacterSetCopyWith<$Res>
    implements $CharacterSetCopyWith<$Res> {
  factory _$$_CharacterSetCopyWith(
          _$_CharacterSet value, $Res Function(_$_CharacterSet) then) =
      __$$_CharacterSetCopyWithImpl<$Res>;
  @override
  $Res call({String name, List<Character> characters, String fontName});
}

/// @nodoc
class __$$_CharacterSetCopyWithImpl<$Res>
    extends _$CharacterSetCopyWithImpl<$Res>
    implements _$$_CharacterSetCopyWith<$Res> {
  __$$_CharacterSetCopyWithImpl(
      _$_CharacterSet _value, $Res Function(_$_CharacterSet) _then)
      : super(_value, (v) => _then(v as _$_CharacterSet));

  @override
  _$_CharacterSet get _value => super._value as _$_CharacterSet;

  @override
  $Res call({
    Object? name = freezed,
    Object? characters = freezed,
    Object? fontName = freezed,
  }) {
    return _then(_$_CharacterSet(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      characters: characters == freezed
          ? _value._characters
          : characters // ignore: cast_nullable_to_non_nullable
              as List<Character>,
      fontName: fontName == freezed
          ? _value.fontName
          : fontName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CharacterSet extends _CharacterSet {
  const _$_CharacterSet(
      {required this.name,
      required final List<Character> characters,
      this.fontName = defautlFontName})
      : _characters = characters,
        super._();

  factory _$_CharacterSet.fromJson(Map<String, dynamic> json) =>
      _$$_CharacterSetFromJson(json);

  @override
  final String name;
  final List<Character> _characters;
  @override
  List<Character> get characters {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_characters);
  }

  @override
  @JsonKey()
  final String fontName;

  @override
  String toString() {
    return 'CharacterSet(name: $name, characters: $characters, fontName: $fontName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CharacterSet &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other._characters, _characters) &&
            const DeepCollectionEquality().equals(other.fontName, fontName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(_characters),
      const DeepCollectionEquality().hash(fontName));

  @JsonKey(ignore: true)
  @override
  _$$_CharacterSetCopyWith<_$_CharacterSet> get copyWith =>
      __$$_CharacterSetCopyWithImpl<_$_CharacterSet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CharacterSetToJson(
      this,
    );
  }
}

abstract class _CharacterSet extends CharacterSet {
  const factory _CharacterSet(
      {required final String name,
      required final List<Character> characters,
      final String fontName}) = _$_CharacterSet;
  const _CharacterSet._() : super._();

  factory _CharacterSet.fromJson(Map<String, dynamic> json) =
      _$_CharacterSet.fromJson;

  @override
  String get name;
  @override
  List<Character> get characters;
  @override
  String get fontName;
  @override
  @JsonKey(ignore: true)
  _$$_CharacterSetCopyWith<_$_CharacterSet> get copyWith =>
      throw _privateConstructorUsedError;
}

Segment _$SegmentFromJson(Map<String, dynamic> json) {
  return _Segment.fromJson(json);
}

/// @nodoc
mixin _$Segment {
  String get path => throw _privateConstructorUsedError;
  @JsonKey(fromJson: tuple2FromJson, toJson: tuple2ToJson)
  Tuple2<double, double> get interval => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SegmentCopyWith<Segment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SegmentCopyWith<$Res> {
  factory $SegmentCopyWith(Segment value, $Res Function(Segment) then) =
      _$SegmentCopyWithImpl<$Res>;
  $Res call(
      {String path,
      @JsonKey(fromJson: tuple2FromJson, toJson: tuple2ToJson)
          Tuple2<double, double> interval});
}

/// @nodoc
class _$SegmentCopyWithImpl<$Res> implements $SegmentCopyWith<$Res> {
  _$SegmentCopyWithImpl(this._value, this._then);

  final Segment _value;
  // ignore: unused_field
  final $Res Function(Segment) _then;

  @override
  $Res call({
    Object? path = freezed,
    Object? interval = freezed,
  }) {
    return _then(_value.copyWith(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      interval: interval == freezed
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Tuple2<double, double>,
    ));
  }
}

/// @nodoc
abstract class _$$_SegmentCopyWith<$Res> implements $SegmentCopyWith<$Res> {
  factory _$$_SegmentCopyWith(
          _$_Segment value, $Res Function(_$_Segment) then) =
      __$$_SegmentCopyWithImpl<$Res>;
  @override
  $Res call(
      {String path,
      @JsonKey(fromJson: tuple2FromJson, toJson: tuple2ToJson)
          Tuple2<double, double> interval});
}

/// @nodoc
class __$$_SegmentCopyWithImpl<$Res> extends _$SegmentCopyWithImpl<$Res>
    implements _$$_SegmentCopyWith<$Res> {
  __$$_SegmentCopyWithImpl(_$_Segment _value, $Res Function(_$_Segment) _then)
      : super(_value, (v) => _then(v as _$_Segment));

  @override
  _$_Segment get _value => super._value as _$_Segment;

  @override
  $Res call({
    Object? path = freezed,
    Object? interval = freezed,
  }) {
    return _then(_$_Segment(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      interval: interval == freezed
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Tuple2<double, double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Segment extends _Segment {
  const _$_Segment(
      {required this.path,
      @JsonKey(fromJson: tuple2FromJson, toJson: tuple2ToJson)
          required this.interval})
      : super._();

  factory _$_Segment.fromJson(Map<String, dynamic> json) =>
      _$$_SegmentFromJson(json);

  @override
  final String path;
  @override
  @JsonKey(fromJson: tuple2FromJson, toJson: tuple2ToJson)
  final Tuple2<double, double> interval;

  @override
  String toString() {
    return 'Segment(path: $path, interval: $interval)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Segment &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality().equals(other.interval, interval));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(interval));

  @JsonKey(ignore: true)
  @override
  _$$_SegmentCopyWith<_$_Segment> get copyWith =>
      __$$_SegmentCopyWithImpl<_$_Segment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SegmentToJson(
      this,
    );
  }
}

abstract class _Segment extends Segment {
  const factory _Segment(
      {required final String path,
      @JsonKey(fromJson: tuple2FromJson, toJson: tuple2ToJson)
          required final Tuple2<double, double> interval}) = _$_Segment;
  const _Segment._() : super._();

  factory _Segment.fromJson(Map<String, dynamic> json) = _$_Segment.fromJson;

  @override
  String get path;
  @override
  @JsonKey(fromJson: tuple2FromJson, toJson: tuple2ToJson)
  Tuple2<double, double> get interval;
  @override
  @JsonKey(ignore: true)
  _$$_SegmentCopyWith<_$_Segment> get copyWith =>
      throw _privateConstructorUsedError;
}
