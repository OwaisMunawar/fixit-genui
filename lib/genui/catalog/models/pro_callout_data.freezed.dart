// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pro_callout_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProCalloutData {

 String get title; List<String> get reasons; double get costLow; double get costHigh; String? get trade; String get currency; ContentOrigin get origin;
/// Create a copy of ProCalloutData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProCalloutDataCopyWith<ProCalloutData> get copyWith => _$ProCalloutDataCopyWithImpl<ProCalloutData>(this as ProCalloutData, _$identity);

  /// Serializes this ProCalloutData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProCalloutData&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.reasons, reasons)&&(identical(other.costLow, costLow) || other.costLow == costLow)&&(identical(other.costHigh, costHigh) || other.costHigh == costHigh)&&(identical(other.trade, trade) || other.trade == trade)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.origin, origin) || other.origin == origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(reasons),costLow,costHigh,trade,currency,origin);

@override
String toString() {
  return 'ProCalloutData(title: $title, reasons: $reasons, costLow: $costLow, costHigh: $costHigh, trade: $trade, currency: $currency, origin: $origin)';
}


}

/// @nodoc
abstract mixin class $ProCalloutDataCopyWith<$Res>  {
  factory $ProCalloutDataCopyWith(ProCalloutData value, $Res Function(ProCalloutData) _then) = _$ProCalloutDataCopyWithImpl;
@useResult
$Res call({
 String title, List<String> reasons, double costLow, double costHigh, String? trade, String currency, ContentOrigin origin
});




}
/// @nodoc
class _$ProCalloutDataCopyWithImpl<$Res>
    implements $ProCalloutDataCopyWith<$Res> {
  _$ProCalloutDataCopyWithImpl(this._self, this._then);

  final ProCalloutData _self;
  final $Res Function(ProCalloutData) _then;

/// Create a copy of ProCalloutData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? reasons = null,Object? costLow = null,Object? costHigh = null,Object? trade = freezed,Object? currency = null,Object? origin = null,}) {
  return _then(ProCalloutData(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,reasons: null == reasons ? _self.reasons : reasons // ignore: cast_nullable_to_non_nullable
as List<String>,costLow: null == costLow ? _self.costLow : costLow // ignore: cast_nullable_to_non_nullable
as double,costHigh: null == costHigh ? _self.costHigh : costHigh // ignore: cast_nullable_to_non_nullable
as double,trade: freezed == trade ? _self.trade : trade // ignore: cast_nullable_to_non_nullable
as String?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as ContentOrigin,
  ));
}

}


/// Adds pattern-matching-related methods to [ProCalloutData].
extension ProCalloutDataPatterns on ProCalloutData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProCalloutData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProCalloutData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProCalloutData value)  $default,){
final _that = this;
switch (_that) {
case _ProCalloutData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProCalloutData value)?  $default,){
final _that = this;
switch (_that) {
case _ProCalloutData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  List<String> reasons,  double costLow,  double costHigh,  String? trade,  String currency,  ContentOrigin origin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProCalloutData() when $default != null:
return $default(_that.title,_that.reasons,_that.costLow,_that.costHigh,_that.trade,_that.currency,_that.origin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  List<String> reasons,  double costLow,  double costHigh,  String? trade,  String currency,  ContentOrigin origin)  $default,) {final _that = this;
switch (_that) {
case _ProCalloutData():
return $default(_that.title,_that.reasons,_that.costLow,_that.costHigh,_that.trade,_that.currency,_that.origin);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  List<String> reasons,  double costLow,  double costHigh,  String? trade,  String currency,  ContentOrigin origin)?  $default,) {final _that = this;
switch (_that) {
case _ProCalloutData() when $default != null:
return $default(_that.title,_that.reasons,_that.costLow,_that.costHigh,_that.trade,_that.currency,_that.origin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProCalloutData implements ProCalloutData {
  const _ProCalloutData({required this.title, required  List<String> reasons, required this.costLow, required this.costHigh, this.trade, this.currency = 'USD', this.origin = ContentOrigin.model}): _reasons = reasons;
  factory _ProCalloutData.fromJson(Map<String, dynamic> json) => _$ProCalloutDataFromJson(json);

@override final  String title;
 final  List<String> _reasons;
@override List<String> get reasons {
  if (_reasons is EqualUnmodifiableListView) return _reasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reasons);
}

@override final  double costLow;
@override final  double costHigh;
@override final  String? trade;
@override@JsonKey() final  String currency;
@override@JsonKey() final  ContentOrigin origin;

/// Create a copy of ProCalloutData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProCalloutDataCopyWith<_ProCalloutData> get copyWith => __$ProCalloutDataCopyWithImpl<_ProCalloutData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProCalloutDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProCalloutData&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._reasons, _reasons)&&(identical(other.costLow, costLow) || other.costLow == costLow)&&(identical(other.costHigh, costHigh) || other.costHigh == costHigh)&&(identical(other.trade, trade) || other.trade == trade)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.origin, origin) || other.origin == origin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_reasons),costLow,costHigh,trade,currency,origin);

@override
String toString() {
  return 'ProCalloutData(title: $title, reasons: $reasons, costLow: $costLow, costHigh: $costHigh, trade: $trade, currency: $currency, origin: $origin)';
}


}

/// @nodoc
abstract mixin class _$ProCalloutDataCopyWith<$Res> implements $ProCalloutDataCopyWith<$Res> {
  factory _$ProCalloutDataCopyWith(_ProCalloutData value, $Res Function(_ProCalloutData) _then) = __$ProCalloutDataCopyWithImpl;
@override @useResult
$Res call({
 String title, List<String> reasons, double costLow, double costHigh, String? trade, String currency, ContentOrigin origin
});




}
/// @nodoc
class __$ProCalloutDataCopyWithImpl<$Res>
    implements _$ProCalloutDataCopyWith<$Res> {
  __$ProCalloutDataCopyWithImpl(this._self, this._then);

  final _ProCalloutData _self;
  final $Res Function(_ProCalloutData) _then;

/// Create a copy of ProCalloutData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? reasons = null,Object? costLow = null,Object? costHigh = null,Object? trade = freezed,Object? currency = null,Object? origin = null,}) {
  return _then(_ProCalloutData(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,reasons: null == reasons ? _self._reasons : reasons // ignore: cast_nullable_to_non_nullable
as List<String>,costLow: null == costLow ? _self.costLow : costLow // ignore: cast_nullable_to_non_nullable
as double,costHigh: null == costHigh ? _self.costHigh : costHigh // ignore: cast_nullable_to_non_nullable
as double,trade: freezed == trade ? _self.trade : trade // ignore: cast_nullable_to_non_nullable
as String?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as ContentOrigin,
  ));
}


}

// dart format on
