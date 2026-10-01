// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response_stack_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResponseStackData {

 List<String> get children;
/// Create a copy of ResponseStackData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResponseStackDataCopyWith<ResponseStackData> get copyWith => _$ResponseStackDataCopyWithImpl<ResponseStackData>(this as ResponseStackData, _$identity);

  /// Serializes this ResponseStackData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResponseStackData&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'ResponseStackData(children: $children)';
}


}

/// @nodoc
abstract mixin class $ResponseStackDataCopyWith<$Res>  {
  factory $ResponseStackDataCopyWith(ResponseStackData value, $Res Function(ResponseStackData) _then) = _$ResponseStackDataCopyWithImpl;
@useResult
$Res call({
 List<String> children
});




}
/// @nodoc
class _$ResponseStackDataCopyWithImpl<$Res>
    implements $ResponseStackDataCopyWith<$Res> {
  _$ResponseStackDataCopyWithImpl(this._self, this._then);

  final ResponseStackData _self;
  final $Res Function(ResponseStackData) _then;

/// Create a copy of ResponseStackData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? children = null,}) {
  return _then(ResponseStackData(
children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ResponseStackData].
extension ResponseStackDataPatterns on ResponseStackData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResponseStackData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResponseStackData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResponseStackData value)  $default,){
final _that = this;
switch (_that) {
case _ResponseStackData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResponseStackData value)?  $default,){
final _that = this;
switch (_that) {
case _ResponseStackData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResponseStackData() when $default != null:
return $default(_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> children)  $default,) {final _that = this;
switch (_that) {
case _ResponseStackData():
return $default(_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> children)?  $default,) {final _that = this;
switch (_that) {
case _ResponseStackData() when $default != null:
return $default(_that.children);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResponseStackData implements ResponseStackData {
  const _ResponseStackData({required  List<String> children}): _children = children;
  factory _ResponseStackData.fromJson(Map<String, dynamic> json) => _$ResponseStackDataFromJson(json);

 final  List<String> _children;
@override List<String> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}


/// Create a copy of ResponseStackData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResponseStackDataCopyWith<_ResponseStackData> get copyWith => __$ResponseStackDataCopyWithImpl<_ResponseStackData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResponseStackDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResponseStackData&&const DeepCollectionEquality().equals(other._children, _children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_children));

@override
String toString() {
  return 'ResponseStackData(children: $children)';
}


}

/// @nodoc
abstract mixin class _$ResponseStackDataCopyWith<$Res> implements $ResponseStackDataCopyWith<$Res> {
  factory _$ResponseStackDataCopyWith(_ResponseStackData value, $Res Function(_ResponseStackData) _then) = __$ResponseStackDataCopyWithImpl;
@override @useResult
$Res call({
 List<String> children
});




}
/// @nodoc
class __$ResponseStackDataCopyWithImpl<$Res>
    implements _$ResponseStackDataCopyWith<$Res> {
  __$ResponseStackDataCopyWithImpl(this._self, this._then);

  final _ResponseStackData _self;
  final $Res Function(_ResponseStackData) _then;

/// Create a copy of ResponseStackData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? children = null,}) {
  return _then(_ResponseStackData(
children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
