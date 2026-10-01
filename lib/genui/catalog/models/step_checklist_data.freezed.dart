// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'step_checklist_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StepChecklistData {

 String get title; List<ChecklistStep> get steps; int? get estimatedMinutes;
/// Create a copy of StepChecklistData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepChecklistDataCopyWith<StepChecklistData> get copyWith => _$StepChecklistDataCopyWithImpl<StepChecklistData>(this as StepChecklistData, _$identity);

  /// Serializes this StepChecklistData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepChecklistData&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.steps, steps)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(steps),estimatedMinutes);

@override
String toString() {
  return 'StepChecklistData(title: $title, steps: $steps, estimatedMinutes: $estimatedMinutes)';
}


}

/// @nodoc
abstract mixin class $StepChecklistDataCopyWith<$Res>  {
  factory $StepChecklistDataCopyWith(StepChecklistData value, $Res Function(StepChecklistData) _then) = _$StepChecklistDataCopyWithImpl;
@useResult
$Res call({
 String title, List<ChecklistStep> steps, int? estimatedMinutes
});




}
/// @nodoc
class _$StepChecklistDataCopyWithImpl<$Res>
    implements $StepChecklistDataCopyWith<$Res> {
  _$StepChecklistDataCopyWithImpl(this._self, this._then);

  final StepChecklistData _self;
  final $Res Function(StepChecklistData) _then;

/// Create a copy of StepChecklistData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? steps = null,Object? estimatedMinutes = freezed,}) {
  return _then(StepChecklistData(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<ChecklistStep>,estimatedMinutes: freezed == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [StepChecklistData].
extension StepChecklistDataPatterns on StepChecklistData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StepChecklistData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StepChecklistData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StepChecklistData value)  $default,){
final _that = this;
switch (_that) {
case _StepChecklistData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StepChecklistData value)?  $default,){
final _that = this;
switch (_that) {
case _StepChecklistData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  List<ChecklistStep> steps,  int? estimatedMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StepChecklistData() when $default != null:
return $default(_that.title,_that.steps,_that.estimatedMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  List<ChecklistStep> steps,  int? estimatedMinutes)  $default,) {final _that = this;
switch (_that) {
case _StepChecklistData():
return $default(_that.title,_that.steps,_that.estimatedMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  List<ChecklistStep> steps,  int? estimatedMinutes)?  $default,) {final _that = this;
switch (_that) {
case _StepChecklistData() when $default != null:
return $default(_that.title,_that.steps,_that.estimatedMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StepChecklistData extends StepChecklistData {
  const _StepChecklistData({required this.title, required  List<ChecklistStep> steps, this.estimatedMinutes}): _steps = steps,super._();
  factory _StepChecklistData.fromJson(Map<String, dynamic> json) => _$StepChecklistDataFromJson(json);

@override final  String title;
 final  List<ChecklistStep> _steps;
@override List<ChecklistStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

@override final  int? estimatedMinutes;

/// Create a copy of StepChecklistData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StepChecklistDataCopyWith<_StepChecklistData> get copyWith => __$StepChecklistDataCopyWithImpl<_StepChecklistData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StepChecklistDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepChecklistData&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._steps, _steps)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_steps),estimatedMinutes);

@override
String toString() {
  return 'StepChecklistData(title: $title, steps: $steps, estimatedMinutes: $estimatedMinutes)';
}


}

/// @nodoc
abstract mixin class _$StepChecklistDataCopyWith<$Res> implements $StepChecklistDataCopyWith<$Res> {
  factory _$StepChecklistDataCopyWith(_StepChecklistData value, $Res Function(_StepChecklistData) _then) = __$StepChecklistDataCopyWithImpl;
@override @useResult
$Res call({
 String title, List<ChecklistStep> steps, int? estimatedMinutes
});




}
/// @nodoc
class __$StepChecklistDataCopyWithImpl<$Res>
    implements _$StepChecklistDataCopyWith<$Res> {
  __$StepChecklistDataCopyWithImpl(this._self, this._then);

  final _StepChecklistData _self;
  final $Res Function(_StepChecklistData) _then;

/// Create a copy of StepChecklistData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? steps = null,Object? estimatedMinutes = freezed,}) {
  return _then(_StepChecklistData(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<ChecklistStep>,estimatedMinutes: freezed == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ChecklistStep {

 String get id; String get title; String? get detail; int? get minutes; String? get safety;
/// Create a copy of ChecklistStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChecklistStepCopyWith<ChecklistStep> get copyWith => _$ChecklistStepCopyWithImpl<ChecklistStep>(this as ChecklistStep, _$identity);

  /// Serializes this ChecklistStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChecklistStep&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.safety, safety) || other.safety == safety));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,detail,minutes,safety);

@override
String toString() {
  return 'ChecklistStep(id: $id, title: $title, detail: $detail, minutes: $minutes, safety: $safety)';
}


}

/// @nodoc
abstract mixin class $ChecklistStepCopyWith<$Res>  {
  factory $ChecklistStepCopyWith(ChecklistStep value, $Res Function(ChecklistStep) _then) = _$ChecklistStepCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? detail, int? minutes, String? safety
});




}
/// @nodoc
class _$ChecklistStepCopyWithImpl<$Res>
    implements $ChecklistStepCopyWith<$Res> {
  _$ChecklistStepCopyWithImpl(this._self, this._then);

  final ChecklistStep _self;
  final $Res Function(ChecklistStep) _then;

/// Create a copy of ChecklistStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? detail = freezed,Object? minutes = freezed,Object? safety = freezed,}) {
  return _then(ChecklistStep(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,minutes: freezed == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int?,safety: freezed == safety ? _self.safety : safety // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChecklistStep].
extension ChecklistStepPatterns on ChecklistStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChecklistStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChecklistStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChecklistStep value)  $default,){
final _that = this;
switch (_that) {
case _ChecklistStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChecklistStep value)?  $default,){
final _that = this;
switch (_that) {
case _ChecklistStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? detail,  int? minutes,  String? safety)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChecklistStep() when $default != null:
return $default(_that.id,_that.title,_that.detail,_that.minutes,_that.safety);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? detail,  int? minutes,  String? safety)  $default,) {final _that = this;
switch (_that) {
case _ChecklistStep():
return $default(_that.id,_that.title,_that.detail,_that.minutes,_that.safety);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? detail,  int? minutes,  String? safety)?  $default,) {final _that = this;
switch (_that) {
case _ChecklistStep() when $default != null:
return $default(_that.id,_that.title,_that.detail,_that.minutes,_that.safety);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChecklistStep implements ChecklistStep {
  const _ChecklistStep({required this.id, required this.title, this.detail, this.minutes, this.safety});
  factory _ChecklistStep.fromJson(Map<String, dynamic> json) => _$ChecklistStepFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? detail;
@override final  int? minutes;
@override final  String? safety;

/// Create a copy of ChecklistStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChecklistStepCopyWith<_ChecklistStep> get copyWith => __$ChecklistStepCopyWithImpl<_ChecklistStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChecklistStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChecklistStep&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.safety, safety) || other.safety == safety));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,detail,minutes,safety);

@override
String toString() {
  return 'ChecklistStep(id: $id, title: $title, detail: $detail, minutes: $minutes, safety: $safety)';
}


}

/// @nodoc
abstract mixin class _$ChecklistStepCopyWith<$Res> implements $ChecklistStepCopyWith<$Res> {
  factory _$ChecklistStepCopyWith(_ChecklistStep value, $Res Function(_ChecklistStep) _then) = __$ChecklistStepCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? detail, int? minutes, String? safety
});




}
/// @nodoc
class __$ChecklistStepCopyWithImpl<$Res>
    implements _$ChecklistStepCopyWith<$Res> {
  __$ChecklistStepCopyWithImpl(this._self, this._then);

  final _ChecklistStep _self;
  final $Res Function(_ChecklistStep) _then;

/// Create a copy of ChecklistStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? detail = freezed,Object? minutes = freezed,Object? safety = freezed,}) {
  return _then(_ChecklistStep(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,minutes: freezed == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int?,safety: freezed == safety ? _self.safety : safety // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
