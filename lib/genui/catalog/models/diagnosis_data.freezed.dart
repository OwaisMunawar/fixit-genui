// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnosis_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiagnosisData {

 String get title; String get likelyCause; double get confidence; Difficulty get difficulty; RepairCategory get category; String? get summary; int? get estimatedMinutes; List<String> get alternatives;
/// Create a copy of DiagnosisData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagnosisDataCopyWith<DiagnosisData> get copyWith => _$DiagnosisDataCopyWithImpl<DiagnosisData>(this as DiagnosisData, _$identity);

  /// Serializes this DiagnosisData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagnosisData&&(identical(other.title, title) || other.title == title)&&(identical(other.likelyCause, likelyCause) || other.likelyCause == likelyCause)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.category, category) || other.category == category)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&const DeepCollectionEquality().equals(other.alternatives, alternatives));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,likelyCause,confidence,difficulty,category,summary,estimatedMinutes,const DeepCollectionEquality().hash(alternatives));

@override
String toString() {
  return 'DiagnosisData(title: $title, likelyCause: $likelyCause, confidence: $confidence, difficulty: $difficulty, category: $category, summary: $summary, estimatedMinutes: $estimatedMinutes, alternatives: $alternatives)';
}


}

/// @nodoc
abstract mixin class $DiagnosisDataCopyWith<$Res>  {
  factory $DiagnosisDataCopyWith(DiagnosisData value, $Res Function(DiagnosisData) _then) = _$DiagnosisDataCopyWithImpl;
@useResult
$Res call({
 String title, String likelyCause, double confidence, Difficulty difficulty, RepairCategory category, String? summary, int? estimatedMinutes, List<String> alternatives
});




}
/// @nodoc
class _$DiagnosisDataCopyWithImpl<$Res>
    implements $DiagnosisDataCopyWith<$Res> {
  _$DiagnosisDataCopyWithImpl(this._self, this._then);

  final DiagnosisData _self;
  final $Res Function(DiagnosisData) _then;

/// Create a copy of DiagnosisData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? likelyCause = null,Object? confidence = null,Object? difficulty = null,Object? category = null,Object? summary = freezed,Object? estimatedMinutes = freezed,Object? alternatives = null,}) {
  return _then(DiagnosisData(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,likelyCause: null == likelyCause ? _self.likelyCause : likelyCause // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as RepairCategory,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,estimatedMinutes: freezed == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int?,alternatives: null == alternatives ? _self.alternatives : alternatives // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DiagnosisData].
extension DiagnosisDataPatterns on DiagnosisData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiagnosisData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiagnosisData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiagnosisData value)  $default,){
final _that = this;
switch (_that) {
case _DiagnosisData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiagnosisData value)?  $default,){
final _that = this;
switch (_that) {
case _DiagnosisData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String likelyCause,  double confidence,  Difficulty difficulty,  RepairCategory category,  String? summary,  int? estimatedMinutes,  List<String> alternatives)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiagnosisData() when $default != null:
return $default(_that.title,_that.likelyCause,_that.confidence,_that.difficulty,_that.category,_that.summary,_that.estimatedMinutes,_that.alternatives);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String likelyCause,  double confidence,  Difficulty difficulty,  RepairCategory category,  String? summary,  int? estimatedMinutes,  List<String> alternatives)  $default,) {final _that = this;
switch (_that) {
case _DiagnosisData():
return $default(_that.title,_that.likelyCause,_that.confidence,_that.difficulty,_that.category,_that.summary,_that.estimatedMinutes,_that.alternatives);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String likelyCause,  double confidence,  Difficulty difficulty,  RepairCategory category,  String? summary,  int? estimatedMinutes,  List<String> alternatives)?  $default,) {final _that = this;
switch (_that) {
case _DiagnosisData() when $default != null:
return $default(_that.title,_that.likelyCause,_that.confidence,_that.difficulty,_that.category,_that.summary,_that.estimatedMinutes,_that.alternatives);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiagnosisData implements DiagnosisData {
  const _DiagnosisData({required this.title, required this.likelyCause, required this.confidence, required this.difficulty, required this.category, this.summary, this.estimatedMinutes,  List<String> alternatives = const <String>[]}): _alternatives = alternatives;
  factory _DiagnosisData.fromJson(Map<String, dynamic> json) => _$DiagnosisDataFromJson(json);

@override final  String title;
@override final  String likelyCause;
@override final  double confidence;
@override final  Difficulty difficulty;
@override final  RepairCategory category;
@override final  String? summary;
@override final  int? estimatedMinutes;
 final  List<String> _alternatives;
@override@JsonKey() List<String> get alternatives {
  if (_alternatives is EqualUnmodifiableListView) return _alternatives;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_alternatives);
}


/// Create a copy of DiagnosisData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagnosisDataCopyWith<_DiagnosisData> get copyWith => __$DiagnosisDataCopyWithImpl<_DiagnosisData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiagnosisDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagnosisData&&(identical(other.title, title) || other.title == title)&&(identical(other.likelyCause, likelyCause) || other.likelyCause == likelyCause)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.category, category) || other.category == category)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&const DeepCollectionEquality().equals(other._alternatives, _alternatives));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,likelyCause,confidence,difficulty,category,summary,estimatedMinutes,const DeepCollectionEquality().hash(_alternatives));

@override
String toString() {
  return 'DiagnosisData(title: $title, likelyCause: $likelyCause, confidence: $confidence, difficulty: $difficulty, category: $category, summary: $summary, estimatedMinutes: $estimatedMinutes, alternatives: $alternatives)';
}


}

/// @nodoc
abstract mixin class _$DiagnosisDataCopyWith<$Res> implements $DiagnosisDataCopyWith<$Res> {
  factory _$DiagnosisDataCopyWith(_DiagnosisData value, $Res Function(_DiagnosisData) _then) = __$DiagnosisDataCopyWithImpl;
@override @useResult
$Res call({
 String title, String likelyCause, double confidence, Difficulty difficulty, RepairCategory category, String? summary, int? estimatedMinutes, List<String> alternatives
});




}
/// @nodoc
class __$DiagnosisDataCopyWithImpl<$Res>
    implements _$DiagnosisDataCopyWith<$Res> {
  __$DiagnosisDataCopyWithImpl(this._self, this._then);

  final _DiagnosisData _self;
  final $Res Function(_DiagnosisData) _then;

/// Create a copy of DiagnosisData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? likelyCause = null,Object? confidence = null,Object? difficulty = null,Object? category = null,Object? summary = freezed,Object? estimatedMinutes = freezed,Object? alternatives = null,}) {
  return _then(_DiagnosisData(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,likelyCause: null == likelyCause ? _self.likelyCause : likelyCause // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as RepairCategory,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,estimatedMinutes: freezed == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int?,alternatives: null == alternatives ? _self._alternatives : alternatives // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
