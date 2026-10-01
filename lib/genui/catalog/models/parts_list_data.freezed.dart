// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parts_list_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartsListData {

 List<PartItem> get items; String? get title; List<String> get tools; String get currency;
/// Create a copy of PartsListData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartsListDataCopyWith<PartsListData> get copyWith => _$PartsListDataCopyWithImpl<PartsListData>(this as PartsListData, _$identity);

  /// Serializes this PartsListData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartsListData&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.tools, tools)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),title,const DeepCollectionEquality().hash(tools),currency);

@override
String toString() {
  return 'PartsListData(items: $items, title: $title, tools: $tools, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $PartsListDataCopyWith<$Res>  {
  factory $PartsListDataCopyWith(PartsListData value, $Res Function(PartsListData) _then) = _$PartsListDataCopyWithImpl;
@useResult
$Res call({
 List<PartItem> items, String? title, List<String> tools, String currency
});




}
/// @nodoc
class _$PartsListDataCopyWithImpl<$Res>
    implements $PartsListDataCopyWith<$Res> {
  _$PartsListDataCopyWithImpl(this._self, this._then);

  final PartsListData _self;
  final $Res Function(PartsListData) _then;

/// Create a copy of PartsListData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? title = freezed,Object? tools = null,Object? currency = null,}) {
  return _then(PartsListData(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PartItem>,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,tools: null == tools ? _self.tools : tools // ignore: cast_nullable_to_non_nullable
as List<String>,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PartsListData].
extension PartsListDataPatterns on PartsListData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartsListData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartsListData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartsListData value)  $default,){
final _that = this;
switch (_that) {
case _PartsListData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartsListData value)?  $default,){
final _that = this;
switch (_that) {
case _PartsListData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PartItem> items,  String? title,  List<String> tools,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartsListData() when $default != null:
return $default(_that.items,_that.title,_that.tools,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PartItem> items,  String? title,  List<String> tools,  String currency)  $default,) {final _that = this;
switch (_that) {
case _PartsListData():
return $default(_that.items,_that.title,_that.tools,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PartItem> items,  String? title,  List<String> tools,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _PartsListData() when $default != null:
return $default(_that.items,_that.title,_that.tools,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartsListData extends PartsListData {
  const _PartsListData({required  List<PartItem> items, this.title,  List<String> tools = const <String>[], this.currency = 'USD'}): _items = items,_tools = tools,super._();
  factory _PartsListData.fromJson(Map<String, dynamic> json) => _$PartsListDataFromJson(json);

 final  List<PartItem> _items;
@override List<PartItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? title;
 final  List<String> _tools;
@override@JsonKey() List<String> get tools {
  if (_tools is EqualUnmodifiableListView) return _tools;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tools);
}

@override@JsonKey() final  String currency;

/// Create a copy of PartsListData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartsListDataCopyWith<_PartsListData> get copyWith => __$PartsListDataCopyWithImpl<_PartsListData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartsListDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartsListData&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._tools, _tools)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),title,const DeepCollectionEquality().hash(_tools),currency);

@override
String toString() {
  return 'PartsListData(items: $items, title: $title, tools: $tools, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$PartsListDataCopyWith<$Res> implements $PartsListDataCopyWith<$Res> {
  factory _$PartsListDataCopyWith(_PartsListData value, $Res Function(_PartsListData) _then) = __$PartsListDataCopyWithImpl;
@override @useResult
$Res call({
 List<PartItem> items, String? title, List<String> tools, String currency
});




}
/// @nodoc
class __$PartsListDataCopyWithImpl<$Res>
    implements _$PartsListDataCopyWith<$Res> {
  __$PartsListDataCopyWithImpl(this._self, this._then);

  final _PartsListData _self;
  final $Res Function(_PartsListData) _then;

/// Create a copy of PartsListData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? title = freezed,Object? tools = null,Object? currency = null,}) {
  return _then(_PartsListData(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PartItem>,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,tools: null == tools ? _self._tools : tools // ignore: cast_nullable_to_non_nullable
as List<String>,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PartItem {

 String get name; int get quantity; double? get unitCost; String? get note;
/// Create a copy of PartItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartItemCopyWith<PartItem> get copyWith => _$PartItemCopyWithImpl<PartItem>(this as PartItem, _$identity);

  /// Serializes this PartItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartItem&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitCost, unitCost) || other.unitCost == unitCost)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,quantity,unitCost,note);

@override
String toString() {
  return 'PartItem(name: $name, quantity: $quantity, unitCost: $unitCost, note: $note)';
}


}

/// @nodoc
abstract mixin class $PartItemCopyWith<$Res>  {
  factory $PartItemCopyWith(PartItem value, $Res Function(PartItem) _then) = _$PartItemCopyWithImpl;
@useResult
$Res call({
 String name, int quantity, double? unitCost, String? note
});




}
/// @nodoc
class _$PartItemCopyWithImpl<$Res>
    implements $PartItemCopyWith<$Res> {
  _$PartItemCopyWithImpl(this._self, this._then);

  final PartItem _self;
  final $Res Function(PartItem) _then;

/// Create a copy of PartItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? quantity = null,Object? unitCost = freezed,Object? note = freezed,}) {
  return _then(PartItem(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitCost: freezed == unitCost ? _self.unitCost : unitCost // ignore: cast_nullable_to_non_nullable
as double?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PartItem].
extension PartItemPatterns on PartItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartItem value)  $default,){
final _that = this;
switch (_that) {
case _PartItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartItem value)?  $default,){
final _that = this;
switch (_that) {
case _PartItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int quantity,  double? unitCost,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartItem() when $default != null:
return $default(_that.name,_that.quantity,_that.unitCost,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int quantity,  double? unitCost,  String? note)  $default,) {final _that = this;
switch (_that) {
case _PartItem():
return $default(_that.name,_that.quantity,_that.unitCost,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int quantity,  double? unitCost,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _PartItem() when $default != null:
return $default(_that.name,_that.quantity,_that.unitCost,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartItem extends PartItem {
  const _PartItem({required this.name, this.quantity = 1, this.unitCost, this.note}): super._();
  factory _PartItem.fromJson(Map<String, dynamic> json) => _$PartItemFromJson(json);

@override final  String name;
@override@JsonKey() final  int quantity;
@override final  double? unitCost;
@override final  String? note;

/// Create a copy of PartItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartItemCopyWith<_PartItem> get copyWith => __$PartItemCopyWithImpl<_PartItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartItem&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitCost, unitCost) || other.unitCost == unitCost)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,quantity,unitCost,note);

@override
String toString() {
  return 'PartItem(name: $name, quantity: $quantity, unitCost: $unitCost, note: $note)';
}


}

/// @nodoc
abstract mixin class _$PartItemCopyWith<$Res> implements $PartItemCopyWith<$Res> {
  factory _$PartItemCopyWith(_PartItem value, $Res Function(_PartItem) _then) = __$PartItemCopyWithImpl;
@override @useResult
$Res call({
 String name, int quantity, double? unitCost, String? note
});




}
/// @nodoc
class __$PartItemCopyWithImpl<$Res>
    implements _$PartItemCopyWith<$Res> {
  __$PartItemCopyWithImpl(this._self, this._then);

  final _PartItem _self;
  final $Res Function(_PartItem) _then;

/// Create a copy of PartItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? quantity = null,Object? unitCost = freezed,Object? note = freezed,}) {
  return _then(_PartItem(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitCost: freezed == unitCost ? _self.unitCost : unitCost // ignore: cast_nullable_to_non_nullable
as double?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
