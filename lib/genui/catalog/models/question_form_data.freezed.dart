// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_form_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionFormData {

 String get title; List<Question> get questions; String? get intro; String? get submitLabel;
/// Create a copy of QuestionFormData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionFormDataCopyWith<QuestionFormData> get copyWith => _$QuestionFormDataCopyWithImpl<QuestionFormData>(this as QuestionFormData, _$identity);

  /// Serializes this QuestionFormData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionFormData&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.questions, questions)&&(identical(other.intro, intro) || other.intro == intro)&&(identical(other.submitLabel, submitLabel) || other.submitLabel == submitLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(questions),intro,submitLabel);

@override
String toString() {
  return 'QuestionFormData(title: $title, questions: $questions, intro: $intro, submitLabel: $submitLabel)';
}


}

/// @nodoc
abstract mixin class $QuestionFormDataCopyWith<$Res>  {
  factory $QuestionFormDataCopyWith(QuestionFormData value, $Res Function(QuestionFormData) _then) = _$QuestionFormDataCopyWithImpl;
@useResult
$Res call({
 String title, List<Question> questions, String? intro, String? submitLabel
});




}
/// @nodoc
class _$QuestionFormDataCopyWithImpl<$Res>
    implements $QuestionFormDataCopyWith<$Res> {
  _$QuestionFormDataCopyWithImpl(this._self, this._then);

  final QuestionFormData _self;
  final $Res Function(QuestionFormData) _then;

/// Create a copy of QuestionFormData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? questions = null,Object? intro = freezed,Object? submitLabel = freezed,}) {
  return _then(QuestionFormData(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,intro: freezed == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as String?,submitLabel: freezed == submitLabel ? _self.submitLabel : submitLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionFormData].
extension QuestionFormDataPatterns on QuestionFormData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionFormData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionFormData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionFormData value)  $default,){
final _that = this;
switch (_that) {
case _QuestionFormData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionFormData value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionFormData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  List<Question> questions,  String? intro,  String? submitLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionFormData() when $default != null:
return $default(_that.title,_that.questions,_that.intro,_that.submitLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  List<Question> questions,  String? intro,  String? submitLabel)  $default,) {final _that = this;
switch (_that) {
case _QuestionFormData():
return $default(_that.title,_that.questions,_that.intro,_that.submitLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  List<Question> questions,  String? intro,  String? submitLabel)?  $default,) {final _that = this;
switch (_that) {
case _QuestionFormData() when $default != null:
return $default(_that.title,_that.questions,_that.intro,_that.submitLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionFormData implements QuestionFormData {
  const _QuestionFormData({required this.title, required  List<Question> questions, this.intro, this.submitLabel}): _questions = questions;
  factory _QuestionFormData.fromJson(Map<String, dynamic> json) => _$QuestionFormDataFromJson(json);

@override final  String title;
 final  List<Question> _questions;
@override List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

@override final  String? intro;
@override final  String? submitLabel;

/// Create a copy of QuestionFormData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionFormDataCopyWith<_QuestionFormData> get copyWith => __$QuestionFormDataCopyWithImpl<_QuestionFormData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionFormDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionFormData&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.intro, intro) || other.intro == intro)&&(identical(other.submitLabel, submitLabel) || other.submitLabel == submitLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_questions),intro,submitLabel);

@override
String toString() {
  return 'QuestionFormData(title: $title, questions: $questions, intro: $intro, submitLabel: $submitLabel)';
}


}

/// @nodoc
abstract mixin class _$QuestionFormDataCopyWith<$Res> implements $QuestionFormDataCopyWith<$Res> {
  factory _$QuestionFormDataCopyWith(_QuestionFormData value, $Res Function(_QuestionFormData) _then) = __$QuestionFormDataCopyWithImpl;
@override @useResult
$Res call({
 String title, List<Question> questions, String? intro, String? submitLabel
});




}
/// @nodoc
class __$QuestionFormDataCopyWithImpl<$Res>
    implements _$QuestionFormDataCopyWith<$Res> {
  __$QuestionFormDataCopyWithImpl(this._self, this._then);

  final _QuestionFormData _self;
  final $Res Function(_QuestionFormData) _then;

/// Create a copy of QuestionFormData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? questions = null,Object? intro = freezed,Object? submitLabel = freezed,}) {
  return _then(_QuestionFormData(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,intro: freezed == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as String?,submitLabel: freezed == submitLabel ? _self.submitLabel : submitLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Question {

 String get id; String get label; QuestionType get type; List<QuestionOption> get options; double? get min; double? get max; double? get step; String? get unit; String? get helper; bool get required;
/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCopyWith<Question> get copyWith => _$QuestionCopyWithImpl<Question>(this as Question, _$identity);

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Question&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.min, min) || other.min == min)&&(identical(other.max, max) || other.max == max)&&(identical(other.step, step) || other.step == step)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.helper, helper) || other.helper == helper)&&(identical(other.required, required) || other.required == required));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,type,const DeepCollectionEquality().hash(options),min,max,step,unit,helper,required);

@override
String toString() {
  return 'Question(id: $id, label: $label, type: $type, options: $options, min: $min, max: $max, step: $step, unit: $unit, helper: $helper, required: $required)';
}


}

/// @nodoc
abstract mixin class $QuestionCopyWith<$Res>  {
  factory $QuestionCopyWith(Question value, $Res Function(Question) _then) = _$QuestionCopyWithImpl;
@useResult
$Res call({
 String id, String label, QuestionType type, List<QuestionOption> options, double? min, double? max, double? step, String? unit, String? helper, bool required
});




}
/// @nodoc
class _$QuestionCopyWithImpl<$Res>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._self, this._then);

  final Question _self;
  final $Res Function(Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? type = null,Object? options = null,Object? min = freezed,Object? max = freezed,Object? step = freezed,Object? unit = freezed,Object? helper = freezed,Object? required = null,}) {
  return _then(Question(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<QuestionOption>,min: freezed == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as double?,max: freezed == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as double?,step: freezed == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as double?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,helper: freezed == helper ? _self.helper : helper // ignore: cast_nullable_to_non_nullable
as String?,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Question].
extension QuestionPatterns on Question {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Question value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Question value)  $default,){
final _that = this;
switch (_that) {
case _Question():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Question value)?  $default,){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  QuestionType type,  List<QuestionOption> options,  double? min,  double? max,  double? step,  String? unit,  String? helper,  bool required)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.label,_that.type,_that.options,_that.min,_that.max,_that.step,_that.unit,_that.helper,_that.required);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  QuestionType type,  List<QuestionOption> options,  double? min,  double? max,  double? step,  String? unit,  String? helper,  bool required)  $default,) {final _that = this;
switch (_that) {
case _Question():
return $default(_that.id,_that.label,_that.type,_that.options,_that.min,_that.max,_that.step,_that.unit,_that.helper,_that.required);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  QuestionType type,  List<QuestionOption> options,  double? min,  double? max,  double? step,  String? unit,  String? helper,  bool required)?  $default,) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.label,_that.type,_that.options,_that.min,_that.max,_that.step,_that.unit,_that.helper,_that.required);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Question implements Question {
  const _Question({required this.id, required this.label, required this.type,  List<QuestionOption> options = const <QuestionOption>[], this.min, this.max, this.step, this.unit, this.helper, this.required = true}): _options = options;
  factory _Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

@override final  String id;
@override final  String label;
@override final  QuestionType type;
 final  List<QuestionOption> _options;
@override@JsonKey() List<QuestionOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  double? min;
@override final  double? max;
@override final  double? step;
@override final  String? unit;
@override final  String? helper;
@override@JsonKey() final  bool required;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionCopyWith<_Question> get copyWith => __$QuestionCopyWithImpl<_Question>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Question&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.min, min) || other.min == min)&&(identical(other.max, max) || other.max == max)&&(identical(other.step, step) || other.step == step)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.helper, helper) || other.helper == helper)&&(identical(other.required, required) || other.required == required));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,type,const DeepCollectionEquality().hash(_options),min,max,step,unit,helper,required);

@override
String toString() {
  return 'Question(id: $id, label: $label, type: $type, options: $options, min: $min, max: $max, step: $step, unit: $unit, helper: $helper, required: $required)';
}


}

/// @nodoc
abstract mixin class _$QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$QuestionCopyWith(_Question value, $Res Function(_Question) _then) = __$QuestionCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, QuestionType type, List<QuestionOption> options, double? min, double? max, double? step, String? unit, String? helper, bool required
});




}
/// @nodoc
class __$QuestionCopyWithImpl<$Res>
    implements _$QuestionCopyWith<$Res> {
  __$QuestionCopyWithImpl(this._self, this._then);

  final _Question _self;
  final $Res Function(_Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? type = null,Object? options = null,Object? min = freezed,Object? max = freezed,Object? step = freezed,Object? unit = freezed,Object? helper = freezed,Object? required = null,}) {
  return _then(_Question(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<QuestionOption>,min: freezed == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as double?,max: freezed == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as double?,step: freezed == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as double?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,helper: freezed == helper ? _self.helper : helper // ignore: cast_nullable_to_non_nullable
as String?,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$QuestionOption {

 String get value; String get label;
/// Create a copy of QuestionOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionOptionCopyWith<QuestionOption> get copyWith => _$QuestionOptionCopyWithImpl<QuestionOption>(this as QuestionOption, _$identity);

  /// Serializes this QuestionOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionOption&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,label);

@override
String toString() {
  return 'QuestionOption(value: $value, label: $label)';
}


}

/// @nodoc
abstract mixin class $QuestionOptionCopyWith<$Res>  {
  factory $QuestionOptionCopyWith(QuestionOption value, $Res Function(QuestionOption) _then) = _$QuestionOptionCopyWithImpl;
@useResult
$Res call({
 String value, String label
});




}
/// @nodoc
class _$QuestionOptionCopyWithImpl<$Res>
    implements $QuestionOptionCopyWith<$Res> {
  _$QuestionOptionCopyWithImpl(this._self, this._then);

  final QuestionOption _self;
  final $Res Function(QuestionOption) _then;

/// Create a copy of QuestionOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? label = null,}) {
  return _then(QuestionOption(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionOption].
extension QuestionOptionPatterns on QuestionOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionOption value)  $default,){
final _that = this;
switch (_that) {
case _QuestionOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionOption value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionOption() when $default != null:
return $default(_that.value,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  String label)  $default,) {final _that = this;
switch (_that) {
case _QuestionOption():
return $default(_that.value,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  String label)?  $default,) {final _that = this;
switch (_that) {
case _QuestionOption() when $default != null:
return $default(_that.value,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionOption implements QuestionOption {
  const _QuestionOption({required this.value, required this.label});
  factory _QuestionOption.fromJson(Map<String, dynamic> json) => _$QuestionOptionFromJson(json);

@override final  String value;
@override final  String label;

/// Create a copy of QuestionOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionOptionCopyWith<_QuestionOption> get copyWith => __$QuestionOptionCopyWithImpl<_QuestionOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionOption&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,label);

@override
String toString() {
  return 'QuestionOption(value: $value, label: $label)';
}


}

/// @nodoc
abstract mixin class _$QuestionOptionCopyWith<$Res> implements $QuestionOptionCopyWith<$Res> {
  factory _$QuestionOptionCopyWith(_QuestionOption value, $Res Function(_QuestionOption) _then) = __$QuestionOptionCopyWithImpl;
@override @useResult
$Res call({
 String value, String label
});




}
/// @nodoc
class __$QuestionOptionCopyWithImpl<$Res>
    implements _$QuestionOptionCopyWith<$Res> {
  __$QuestionOptionCopyWithImpl(this._self, this._then);

  final _QuestionOption _self;
  final $Res Function(_QuestionOption) _then;

/// Create a copy of QuestionOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? label = null,}) {
  return _then(_QuestionOption(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
