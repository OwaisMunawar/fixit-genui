// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checklist_ref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChecklistRef {

 String get surfaceId; String get componentId; List<String> get stepIds;
/// Create a copy of ChecklistRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChecklistRefCopyWith<ChecklistRef> get copyWith => _$ChecklistRefCopyWithImpl<ChecklistRef>(this as ChecklistRef, _$identity);

  /// Serializes this ChecklistRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChecklistRef&&(identical(other.surfaceId, surfaceId) || other.surfaceId == surfaceId)&&(identical(other.componentId, componentId) || other.componentId == componentId)&&const DeepCollectionEquality().equals(other.stepIds, stepIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surfaceId,componentId,const DeepCollectionEquality().hash(stepIds));

@override
String toString() {
  return 'ChecklistRef(surfaceId: $surfaceId, componentId: $componentId, stepIds: $stepIds)';
}


}

/// @nodoc
abstract mixin class $ChecklistRefCopyWith<$Res>  {
  factory $ChecklistRefCopyWith(ChecklistRef value, $Res Function(ChecklistRef) _then) = _$ChecklistRefCopyWithImpl;
@useResult
$Res call({
 String surfaceId, String componentId, List<String> stepIds
});




}
/// @nodoc
class _$ChecklistRefCopyWithImpl<$Res>
    implements $ChecklistRefCopyWith<$Res> {
  _$ChecklistRefCopyWithImpl(this._self, this._then);

  final ChecklistRef _self;
  final $Res Function(ChecklistRef) _then;

/// Create a copy of ChecklistRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surfaceId = null,Object? componentId = null,Object? stepIds = null,}) {
  return _then(ChecklistRef(
surfaceId: null == surfaceId ? _self.surfaceId : surfaceId // ignore: cast_nullable_to_non_nullable
as String,componentId: null == componentId ? _self.componentId : componentId // ignore: cast_nullable_to_non_nullable
as String,stepIds: null == stepIds ? _self.stepIds : stepIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChecklistRef].
extension ChecklistRefPatterns on ChecklistRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChecklistRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChecklistRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChecklistRef value)  $default,){
final _that = this;
switch (_that) {
case _ChecklistRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChecklistRef value)?  $default,){
final _that = this;
switch (_that) {
case _ChecklistRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String surfaceId,  String componentId,  List<String> stepIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChecklistRef() when $default != null:
return $default(_that.surfaceId,_that.componentId,_that.stepIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String surfaceId,  String componentId,  List<String> stepIds)  $default,) {final _that = this;
switch (_that) {
case _ChecklistRef():
return $default(_that.surfaceId,_that.componentId,_that.stepIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String surfaceId,  String componentId,  List<String> stepIds)?  $default,) {final _that = this;
switch (_that) {
case _ChecklistRef() when $default != null:
return $default(_that.surfaceId,_that.componentId,_that.stepIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChecklistRef extends ChecklistRef {
  const _ChecklistRef({required this.surfaceId, required this.componentId, required  List<String> stepIds}): _stepIds = stepIds,super._();
  factory _ChecklistRef.fromJson(Map<String, dynamic> json) => _$ChecklistRefFromJson(json);

@override final  String surfaceId;
@override final  String componentId;
 final  List<String> _stepIds;
@override List<String> get stepIds {
  if (_stepIds is EqualUnmodifiableListView) return _stepIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stepIds);
}


/// Create a copy of ChecklistRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChecklistRefCopyWith<_ChecklistRef> get copyWith => __$ChecklistRefCopyWithImpl<_ChecklistRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChecklistRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChecklistRef&&(identical(other.surfaceId, surfaceId) || other.surfaceId == surfaceId)&&(identical(other.componentId, componentId) || other.componentId == componentId)&&const DeepCollectionEquality().equals(other._stepIds, _stepIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surfaceId,componentId,const DeepCollectionEquality().hash(_stepIds));

@override
String toString() {
  return 'ChecklistRef(surfaceId: $surfaceId, componentId: $componentId, stepIds: $stepIds)';
}


}

/// @nodoc
abstract mixin class _$ChecklistRefCopyWith<$Res> implements $ChecklistRefCopyWith<$Res> {
  factory _$ChecklistRefCopyWith(_ChecklistRef value, $Res Function(_ChecklistRef) _then) = __$ChecklistRefCopyWithImpl;
@override @useResult
$Res call({
 String surfaceId, String componentId, List<String> stepIds
});




}
/// @nodoc
class __$ChecklistRefCopyWithImpl<$Res>
    implements _$ChecklistRefCopyWith<$Res> {
  __$ChecklistRefCopyWithImpl(this._self, this._then);

  final _ChecklistRef _self;
  final $Res Function(_ChecklistRef) _then;

/// Create a copy of ChecklistRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surfaceId = null,Object? componentId = null,Object? stepIds = null,}) {
  return _then(_ChecklistRef(
surfaceId: null == surfaceId ? _self.surfaceId : surfaceId // ignore: cast_nullable_to_non_nullable
as String,componentId: null == componentId ? _self.componentId : componentId // ignore: cast_nullable_to_non_nullable
as String,stepIds: null == stepIds ? _self._stepIds : stepIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
