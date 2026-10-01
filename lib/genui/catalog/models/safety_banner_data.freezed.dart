// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'safety_banner_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SafetyBannerData {

 SafetySeverity get severity; String get title; String get message; ContentOrigin get origin;
/// Create a copy of SafetyBannerData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SafetyBannerDataCopyWith<SafetyBannerData> get copyWith => _$SafetyBannerDataCopyWithImpl<SafetyBannerData>(this as SafetyBannerData, _$identity);

  /// Serializes this SafetyBannerData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SafetyBannerData&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.origin, origin) || other.origin == origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,severity,title,message,origin);

@override
String toString() {
  return 'SafetyBannerData(severity: $severity, title: $title, message: $message, origin: $origin)';
}


}

/// @nodoc
abstract mixin class $SafetyBannerDataCopyWith<$Res>  {
  factory $SafetyBannerDataCopyWith(SafetyBannerData value, $Res Function(SafetyBannerData) _then) = _$SafetyBannerDataCopyWithImpl;
@useResult
$Res call({
 SafetySeverity severity, String title, String message, ContentOrigin origin
});




}
/// @nodoc
class _$SafetyBannerDataCopyWithImpl<$Res>
    implements $SafetyBannerDataCopyWith<$Res> {
  _$SafetyBannerDataCopyWithImpl(this._self, this._then);

  final SafetyBannerData _self;
  final $Res Function(SafetyBannerData) _then;

/// Create a copy of SafetyBannerData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? severity = null,Object? title = null,Object? message = null,Object? origin = null,}) {
  return _then(SafetyBannerData(
severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as SafetySeverity,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as ContentOrigin,
  ));
}

}


/// Adds pattern-matching-related methods to [SafetyBannerData].
extension SafetyBannerDataPatterns on SafetyBannerData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SafetyBannerData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SafetyBannerData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SafetyBannerData value)  $default,){
final _that = this;
switch (_that) {
case _SafetyBannerData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SafetyBannerData value)?  $default,){
final _that = this;
switch (_that) {
case _SafetyBannerData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SafetySeverity severity,  String title,  String message,  ContentOrigin origin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SafetyBannerData() when $default != null:
return $default(_that.severity,_that.title,_that.message,_that.origin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SafetySeverity severity,  String title,  String message,  ContentOrigin origin)  $default,) {final _that = this;
switch (_that) {
case _SafetyBannerData():
return $default(_that.severity,_that.title,_that.message,_that.origin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SafetySeverity severity,  String title,  String message,  ContentOrigin origin)?  $default,) {final _that = this;
switch (_that) {
case _SafetyBannerData() when $default != null:
return $default(_that.severity,_that.title,_that.message,_that.origin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SafetyBannerData implements SafetyBannerData {
  const _SafetyBannerData({required this.severity, required this.title, required this.message, this.origin = ContentOrigin.model});
  factory _SafetyBannerData.fromJson(Map<String, dynamic> json) => _$SafetyBannerDataFromJson(json);

@override final  SafetySeverity severity;
@override final  String title;
@override final  String message;
@override@JsonKey() final  ContentOrigin origin;

/// Create a copy of SafetyBannerData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SafetyBannerDataCopyWith<_SafetyBannerData> get copyWith => __$SafetyBannerDataCopyWithImpl<_SafetyBannerData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SafetyBannerDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SafetyBannerData&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.origin, origin) || other.origin == origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,severity,title,message,origin);

@override
String toString() {
  return 'SafetyBannerData(severity: $severity, title: $title, message: $message, origin: $origin)';
}


}

/// @nodoc
abstract mixin class _$SafetyBannerDataCopyWith<$Res> implements $SafetyBannerDataCopyWith<$Res> {
  factory _$SafetyBannerDataCopyWith(_SafetyBannerData value, $Res Function(_SafetyBannerData) _then) = __$SafetyBannerDataCopyWithImpl;
@override @useResult
$Res call({
 SafetySeverity severity, String title, String message, ContentOrigin origin
});




}
/// @nodoc
class __$SafetyBannerDataCopyWithImpl<$Res>
    implements _$SafetyBannerDataCopyWith<$Res> {
  __$SafetyBannerDataCopyWithImpl(this._self, this._then);

  final _SafetyBannerData _self;
  final $Res Function(_SafetyBannerData) _then;

/// Create a copy of SafetyBannerData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? severity = null,Object? title = null,Object? message = null,Object? origin = null,}) {
  return _then(_SafetyBannerData(
severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as SafetySeverity,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as ContentOrigin,
  ));
}


}

// dart format on
