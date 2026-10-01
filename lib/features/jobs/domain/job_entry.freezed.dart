// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
JobEntry _$JobEntryFromJson(
  Map<String, dynamic> json
) {
        switch (json['kind']) {
                  case 'user':
          return UserEntry.fromJson(
            json
          );
                case 'answers':
          return AnswersEntry.fromJson(
            json
          );
                case 'model':
          return ModelEntry.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'kind',
  'JobEntry',
  'Invalid union type "${json['kind']}"!'
);
        }
      
}

/// @nodoc
mixin _$JobEntry {

 DateTime get createdAt;
/// Create a copy of JobEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobEntryCopyWith<JobEntry> get copyWith => _$JobEntryCopyWithImpl<JobEntry>(this as JobEntry, _$identity);

  /// Serializes this JobEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobEntry&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,createdAt);

@override
String toString() {
  return 'JobEntry(createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $JobEntryCopyWith<$Res>  {
  factory $JobEntryCopyWith(JobEntry value, $Res Function(JobEntry) _then) = _$JobEntryCopyWithImpl;
@useResult
$Res call({
 DateTime createdAt
});




}
/// @nodoc
class _$JobEntryCopyWithImpl<$Res>
    implements $JobEntryCopyWith<$Res> {
  _$JobEntryCopyWithImpl(this._self, this._then);

  final JobEntry _self;
  final $Res Function(JobEntry) _then;

/// Create a copy of JobEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? createdAt = null,}) {
  return _then(_self.copyWith(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [JobEntry].
extension JobEntryPatterns on JobEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UserEntry value)?  user,TResult Function( AnswersEntry value)?  answers,TResult Function( ModelEntry value)?  model,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UserEntry() when user != null:
return user(_that);case AnswersEntry() when answers != null:
return answers(_that);case ModelEntry() when model != null:
return model(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UserEntry value)  user,required TResult Function( AnswersEntry value)  answers,required TResult Function( ModelEntry value)  model,}){
final _that = this;
switch (_that) {
case UserEntry():
return user(_that);case AnswersEntry():
return answers(_that);case ModelEntry():
return model(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UserEntry value)?  user,TResult? Function( AnswersEntry value)?  answers,TResult? Function( ModelEntry value)?  model,}){
final _that = this;
switch (_that) {
case UserEntry() when user != null:
return user(_that);case AnswersEntry() when answers != null:
return answers(_that);case ModelEntry() when model != null:
return model(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String text,  DateTime createdAt,  String? imagePath)?  user,TResult Function( String surfaceId,  String componentId,  String formTitle,  Map<String, Object?> answers,  List<String> summary,  DateTime createdAt)?  answers,TResult Function( String rawResponse,  String text,  List<String> surfaceIds,  List<Map<String, Object?>> messages,  DateTime createdAt,  List<ChecklistRef> checklists,  List<String> categories)?  model,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UserEntry() when user != null:
return user(_that.text,_that.createdAt,_that.imagePath);case AnswersEntry() when answers != null:
return answers(_that.surfaceId,_that.componentId,_that.formTitle,_that.answers,_that.summary,_that.createdAt);case ModelEntry() when model != null:
return model(_that.rawResponse,_that.text,_that.surfaceIds,_that.messages,_that.createdAt,_that.checklists,_that.categories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String text,  DateTime createdAt,  String? imagePath)  user,required TResult Function( String surfaceId,  String componentId,  String formTitle,  Map<String, Object?> answers,  List<String> summary,  DateTime createdAt)  answers,required TResult Function( String rawResponse,  String text,  List<String> surfaceIds,  List<Map<String, Object?>> messages,  DateTime createdAt,  List<ChecklistRef> checklists,  List<String> categories)  model,}) {final _that = this;
switch (_that) {
case UserEntry():
return user(_that.text,_that.createdAt,_that.imagePath);case AnswersEntry():
return answers(_that.surfaceId,_that.componentId,_that.formTitle,_that.answers,_that.summary,_that.createdAt);case ModelEntry():
return model(_that.rawResponse,_that.text,_that.surfaceIds,_that.messages,_that.createdAt,_that.checklists,_that.categories);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String text,  DateTime createdAt,  String? imagePath)?  user,TResult? Function( String surfaceId,  String componentId,  String formTitle,  Map<String, Object?> answers,  List<String> summary,  DateTime createdAt)?  answers,TResult? Function( String rawResponse,  String text,  List<String> surfaceIds,  List<Map<String, Object?>> messages,  DateTime createdAt,  List<ChecklistRef> checklists,  List<String> categories)?  model,}) {final _that = this;
switch (_that) {
case UserEntry() when user != null:
return user(_that.text,_that.createdAt,_that.imagePath);case AnswersEntry() when answers != null:
return answers(_that.surfaceId,_that.componentId,_that.formTitle,_that.answers,_that.summary,_that.createdAt);case ModelEntry() when model != null:
return model(_that.rawResponse,_that.text,_that.surfaceIds,_that.messages,_that.createdAt,_that.checklists,_that.categories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class UserEntry implements JobEntry {
  const UserEntry({required this.text, required this.createdAt, this.imagePath,  String? $type}): $type = $type ?? 'user';
  factory UserEntry.fromJson(Map<String, dynamic> json) => _$UserEntryFromJson(json);

 final  String text;
@override final  DateTime createdAt;
 final  String? imagePath;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of JobEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntryCopyWith<UserEntry> get copyWith => _$UserEntryCopyWithImpl<UserEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntry&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,createdAt,imagePath);

@override
String toString() {
  return 'JobEntry.user(text: $text, createdAt: $createdAt, imagePath: $imagePath)';
}


}

/// @nodoc
abstract mixin class $UserEntryCopyWith<$Res> implements $JobEntryCopyWith<$Res> {
  factory $UserEntryCopyWith(UserEntry value, $Res Function(UserEntry) _then) = _$UserEntryCopyWithImpl;
@override @useResult
$Res call({
 String text, DateTime createdAt, String? imagePath
});




}
/// @nodoc
class _$UserEntryCopyWithImpl<$Res>
    implements $UserEntryCopyWith<$Res> {
  _$UserEntryCopyWithImpl(this._self, this._then);

  final UserEntry _self;
  final $Res Function(UserEntry) _then;

/// Create a copy of JobEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? createdAt = null,Object? imagePath = freezed,}) {
  return _then(UserEntry(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AnswersEntry implements JobEntry {
  const AnswersEntry({required this.surfaceId, required this.componentId, required this.formTitle, required  Map<String, Object?> answers, required  List<String> summary, required this.createdAt,  String? $type}): _answers = answers,_summary = summary,$type = $type ?? 'answers';
  factory AnswersEntry.fromJson(Map<String, dynamic> json) => _$AnswersEntryFromJson(json);

 final  String surfaceId;
 final  String componentId;
 final  String formTitle;
 final  Map<String, Object?> _answers;
 Map<String, Object?> get answers {
  if (_answers is EqualUnmodifiableMapView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_answers);
}

 final  List<String> _summary;
 List<String> get summary {
  if (_summary is EqualUnmodifiableListView) return _summary;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_summary);
}

@override final  DateTime createdAt;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of JobEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnswersEntryCopyWith<AnswersEntry> get copyWith => _$AnswersEntryCopyWithImpl<AnswersEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnswersEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnswersEntry&&(identical(other.surfaceId, surfaceId) || other.surfaceId == surfaceId)&&(identical(other.componentId, componentId) || other.componentId == componentId)&&(identical(other.formTitle, formTitle) || other.formTitle == formTitle)&&const DeepCollectionEquality().equals(other._answers, _answers)&&const DeepCollectionEquality().equals(other._summary, _summary)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surfaceId,componentId,formTitle,const DeepCollectionEquality().hash(_answers),const DeepCollectionEquality().hash(_summary),createdAt);

@override
String toString() {
  return 'JobEntry.answers(surfaceId: $surfaceId, componentId: $componentId, formTitle: $formTitle, answers: $answers, summary: $summary, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AnswersEntryCopyWith<$Res> implements $JobEntryCopyWith<$Res> {
  factory $AnswersEntryCopyWith(AnswersEntry value, $Res Function(AnswersEntry) _then) = _$AnswersEntryCopyWithImpl;
@override @useResult
$Res call({
 String surfaceId, String componentId, String formTitle, Map<String, Object?> answers, List<String> summary, DateTime createdAt
});




}
/// @nodoc
class _$AnswersEntryCopyWithImpl<$Res>
    implements $AnswersEntryCopyWith<$Res> {
  _$AnswersEntryCopyWithImpl(this._self, this._then);

  final AnswersEntry _self;
  final $Res Function(AnswersEntry) _then;

/// Create a copy of JobEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surfaceId = null,Object? componentId = null,Object? formTitle = null,Object? answers = null,Object? summary = null,Object? createdAt = null,}) {
  return _then(AnswersEntry(
surfaceId: null == surfaceId ? _self.surfaceId : surfaceId // ignore: cast_nullable_to_non_nullable
as String,componentId: null == componentId ? _self.componentId : componentId // ignore: cast_nullable_to_non_nullable
as String,formTitle: null == formTitle ? _self.formTitle : formTitle // ignore: cast_nullable_to_non_nullable
as String,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,summary: null == summary ? _self._summary : summary // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ModelEntry implements JobEntry {
  const ModelEntry({required this.rawResponse, required this.text, required  List<String> surfaceIds, required  List<Map<String, Object?>> messages, required this.createdAt,  List<ChecklistRef> checklists = const <ChecklistRef>[],  List<String> categories = const <String>[],  String? $type}): _surfaceIds = surfaceIds,_messages = messages,_checklists = checklists,_categories = categories,$type = $type ?? 'model';
  factory ModelEntry.fromJson(Map<String, dynamic> json) => _$ModelEntryFromJson(json);

 final  String rawResponse;
 final  String text;
 final  List<String> _surfaceIds;
 List<String> get surfaceIds {
  if (_surfaceIds is EqualUnmodifiableListView) return _surfaceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_surfaceIds);
}

 final  List<Map<String, Object?>> _messages;
 List<Map<String, Object?>> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override final  DateTime createdAt;
 final  List<ChecklistRef> _checklists;
@JsonKey() List<ChecklistRef> get checklists {
  if (_checklists is EqualUnmodifiableListView) return _checklists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checklists);
}

 final  List<String> _categories;
@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


@JsonKey(name: 'kind')
final String $type;


/// Create a copy of JobEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModelEntryCopyWith<ModelEntry> get copyWith => _$ModelEntryCopyWithImpl<ModelEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModelEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModelEntry&&(identical(other.rawResponse, rawResponse) || other.rawResponse == rawResponse)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._surfaceIds, _surfaceIds)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._checklists, _checklists)&&const DeepCollectionEquality().equals(other._categories, _categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rawResponse,text,const DeepCollectionEquality().hash(_surfaceIds),const DeepCollectionEquality().hash(_messages),createdAt,const DeepCollectionEquality().hash(_checklists),const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'JobEntry.model(rawResponse: $rawResponse, text: $text, surfaceIds: $surfaceIds, messages: $messages, createdAt: $createdAt, checklists: $checklists, categories: $categories)';
}


}

/// @nodoc
abstract mixin class $ModelEntryCopyWith<$Res> implements $JobEntryCopyWith<$Res> {
  factory $ModelEntryCopyWith(ModelEntry value, $Res Function(ModelEntry) _then) = _$ModelEntryCopyWithImpl;
@override @useResult
$Res call({
 String rawResponse, String text, List<String> surfaceIds, List<Map<String, Object?>> messages, DateTime createdAt, List<ChecklistRef> checklists, List<String> categories
});




}
/// @nodoc
class _$ModelEntryCopyWithImpl<$Res>
    implements $ModelEntryCopyWith<$Res> {
  _$ModelEntryCopyWithImpl(this._self, this._then);

  final ModelEntry _self;
  final $Res Function(ModelEntry) _then;

/// Create a copy of JobEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rawResponse = null,Object? text = null,Object? surfaceIds = null,Object? messages = null,Object? createdAt = null,Object? checklists = null,Object? categories = null,}) {
  return _then(ModelEntry(
rawResponse: null == rawResponse ? _self.rawResponse : rawResponse // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,surfaceIds: null == surfaceIds ? _self._surfaceIds : surfaceIds // ignore: cast_nullable_to_non_nullable
as List<String>,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Map<String, Object?>>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,checklists: null == checklists ? _self._checklists : checklists // ignore: cast_nullable_to_non_nullable
as List<ChecklistRef>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
