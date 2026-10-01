// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimelineItem {

 String get text;
/// Create a copy of TimelineItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineItemCopyWith<TimelineItem> get copyWith => _$TimelineItemCopyWithImpl<TimelineItem>(this as TimelineItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineItem&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'TimelineItem(text: $text)';
}


}

/// @nodoc
abstract mixin class $TimelineItemCopyWith<$Res>  {
  factory $TimelineItemCopyWith(TimelineItem value, $Res Function(TimelineItem) _then) = _$TimelineItemCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$TimelineItemCopyWithImpl<$Res>
    implements $TimelineItemCopyWith<$Res> {
  _$TimelineItemCopyWithImpl(this._self, this._then);

  final TimelineItem _self;
  final $Res Function(TimelineItem) _then;

/// Create a copy of TimelineItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TimelineItem].
extension TimelineItemPatterns on TimelineItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UserTimelineItem value)?  user,TResult Function( ModelTimelineItem value)?  model,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UserTimelineItem() when user != null:
return user(_that);case ModelTimelineItem() when model != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UserTimelineItem value)  user,required TResult Function( ModelTimelineItem value)  model,}){
final _that = this;
switch (_that) {
case UserTimelineItem():
return user(_that);case ModelTimelineItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UserTimelineItem value)?  user,TResult? Function( ModelTimelineItem value)?  model,}){
final _that = this;
switch (_that) {
case UserTimelineItem() when user != null:
return user(_that);case ModelTimelineItem() when model != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String text,  String? imagePath)?  user,TResult Function( String text,  List<String> surfaceIds)?  model,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UserTimelineItem() when user != null:
return user(_that.text,_that.imagePath);case ModelTimelineItem() when model != null:
return model(_that.text,_that.surfaceIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String text,  String? imagePath)  user,required TResult Function( String text,  List<String> surfaceIds)  model,}) {final _that = this;
switch (_that) {
case UserTimelineItem():
return user(_that.text,_that.imagePath);case ModelTimelineItem():
return model(_that.text,_that.surfaceIds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String text,  String? imagePath)?  user,TResult? Function( String text,  List<String> surfaceIds)?  model,}) {final _that = this;
switch (_that) {
case UserTimelineItem() when user != null:
return user(_that.text,_that.imagePath);case ModelTimelineItem() when model != null:
return model(_that.text,_that.surfaceIds);case _:
  return null;

}
}

}

/// @nodoc


class UserTimelineItem implements TimelineItem {
  const UserTimelineItem({required this.text, this.imagePath});
  

@override final  String text;
 final  String? imagePath;

/// Create a copy of TimelineItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserTimelineItemCopyWith<UserTimelineItem> get copyWith => _$UserTimelineItemCopyWithImpl<UserTimelineItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserTimelineItem&&(identical(other.text, text) || other.text == text)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath));
}


@override
int get hashCode => Object.hash(runtimeType,text,imagePath);

@override
String toString() {
  return 'TimelineItem.user(text: $text, imagePath: $imagePath)';
}


}

/// @nodoc
abstract mixin class $UserTimelineItemCopyWith<$Res> implements $TimelineItemCopyWith<$Res> {
  factory $UserTimelineItemCopyWith(UserTimelineItem value, $Res Function(UserTimelineItem) _then) = _$UserTimelineItemCopyWithImpl;
@override @useResult
$Res call({
 String text, String? imagePath
});




}
/// @nodoc
class _$UserTimelineItemCopyWithImpl<$Res>
    implements $UserTimelineItemCopyWith<$Res> {
  _$UserTimelineItemCopyWithImpl(this._self, this._then);

  final UserTimelineItem _self;
  final $Res Function(UserTimelineItem) _then;

/// Create a copy of TimelineItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? imagePath = freezed,}) {
  return _then(UserTimelineItem(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ModelTimelineItem implements TimelineItem {
  const ModelTimelineItem({required this.text, required  List<String> surfaceIds}): _surfaceIds = surfaceIds;
  

@override final  String text;
 final  List<String> _surfaceIds;
 List<String> get surfaceIds {
  if (_surfaceIds is EqualUnmodifiableListView) return _surfaceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_surfaceIds);
}


/// Create a copy of TimelineItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModelTimelineItemCopyWith<ModelTimelineItem> get copyWith => _$ModelTimelineItemCopyWithImpl<ModelTimelineItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModelTimelineItem&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._surfaceIds, _surfaceIds));
}


@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(_surfaceIds));

@override
String toString() {
  return 'TimelineItem.model(text: $text, surfaceIds: $surfaceIds)';
}


}

/// @nodoc
abstract mixin class $ModelTimelineItemCopyWith<$Res> implements $TimelineItemCopyWith<$Res> {
  factory $ModelTimelineItemCopyWith(ModelTimelineItem value, $Res Function(ModelTimelineItem) _then) = _$ModelTimelineItemCopyWithImpl;
@override @useResult
$Res call({
 String text, List<String> surfaceIds
});




}
/// @nodoc
class _$ModelTimelineItemCopyWithImpl<$Res>
    implements $ModelTimelineItemCopyWith<$Res> {
  _$ModelTimelineItemCopyWithImpl(this._self, this._then);

  final ModelTimelineItem _self;
  final $Res Function(ModelTimelineItem) _then;

/// Create a copy of TimelineItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? surfaceIds = null,}) {
  return _then(ModelTimelineItem(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,surfaceIds: null == surfaceIds ? _self._surfaceIds : surfaceIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$JobSessionState {

 Job? get job; List<TimelineItem> get timeline; bool get isLoading; bool get isGenerating; AppFailure? get failure;
/// Create a copy of JobSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobSessionStateCopyWith<JobSessionState> get copyWith => _$JobSessionStateCopyWithImpl<JobSessionState>(this as JobSessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobSessionState&&(identical(other.job, job) || other.job == job)&&const DeepCollectionEquality().equals(other.timeline, timeline)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isGenerating, isGenerating) || other.isGenerating == isGenerating)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,job,const DeepCollectionEquality().hash(timeline),isLoading,isGenerating,failure);

@override
String toString() {
  return 'JobSessionState(job: $job, timeline: $timeline, isLoading: $isLoading, isGenerating: $isGenerating, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $JobSessionStateCopyWith<$Res>  {
  factory $JobSessionStateCopyWith(JobSessionState value, $Res Function(JobSessionState) _then) = _$JobSessionStateCopyWithImpl;
@useResult
$Res call({
 Job? job, List<TimelineItem> timeline, bool isLoading, bool isGenerating, AppFailure? failure
});


$JobCopyWith<$Res>? get job;

}
/// @nodoc
class _$JobSessionStateCopyWithImpl<$Res>
    implements $JobSessionStateCopyWith<$Res> {
  _$JobSessionStateCopyWithImpl(this._self, this._then);

  final JobSessionState _self;
  final $Res Function(JobSessionState) _then;

/// Create a copy of JobSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? job = freezed,Object? timeline = null,Object? isLoading = null,Object? isGenerating = null,Object? failure = freezed,}) {
  return _then(JobSessionState(
job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Job?,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TimelineItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isGenerating: null == isGenerating ? _self.isGenerating : isGenerating // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}
/// Create a copy of JobSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobCopyWith<$Res>? get job {
    if (_self.job == null) {
    return null;
  }

  return $JobCopyWith<$Res>(_self.job!, (value) {
    return _then(_self.copyWith(job: value));
  });
}
}


/// Adds pattern-matching-related methods to [JobSessionState].
extension JobSessionStatePatterns on JobSessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobSessionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobSessionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobSessionState value)  $default,){
final _that = this;
switch (_that) {
case _JobSessionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobSessionState value)?  $default,){
final _that = this;
switch (_that) {
case _JobSessionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Job? job,  List<TimelineItem> timeline,  bool isLoading,  bool isGenerating,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobSessionState() when $default != null:
return $default(_that.job,_that.timeline,_that.isLoading,_that.isGenerating,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Job? job,  List<TimelineItem> timeline,  bool isLoading,  bool isGenerating,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _JobSessionState():
return $default(_that.job,_that.timeline,_that.isLoading,_that.isGenerating,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Job? job,  List<TimelineItem> timeline,  bool isLoading,  bool isGenerating,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _JobSessionState() when $default != null:
return $default(_that.job,_that.timeline,_that.isLoading,_that.isGenerating,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _JobSessionState extends JobSessionState {
  const _JobSessionState({this.job,  List<TimelineItem> timeline = const <TimelineItem>[], this.isLoading = true, this.isGenerating = false, this.failure}): _timeline = timeline,super._();
  

@override final  Job? job;
 final  List<TimelineItem> _timeline;
@override@JsonKey() List<TimelineItem> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isGenerating;
@override final  AppFailure? failure;

/// Create a copy of JobSessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobSessionStateCopyWith<_JobSessionState> get copyWith => __$JobSessionStateCopyWithImpl<_JobSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobSessionState&&(identical(other.job, job) || other.job == job)&&const DeepCollectionEquality().equals(other._timeline, _timeline)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isGenerating, isGenerating) || other.isGenerating == isGenerating)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,job,const DeepCollectionEquality().hash(_timeline),isLoading,isGenerating,failure);

@override
String toString() {
  return 'JobSessionState(job: $job, timeline: $timeline, isLoading: $isLoading, isGenerating: $isGenerating, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$JobSessionStateCopyWith<$Res> implements $JobSessionStateCopyWith<$Res> {
  factory _$JobSessionStateCopyWith(_JobSessionState value, $Res Function(_JobSessionState) _then) = __$JobSessionStateCopyWithImpl;
@override @useResult
$Res call({
 Job? job, List<TimelineItem> timeline, bool isLoading, bool isGenerating, AppFailure? failure
});


@override $JobCopyWith<$Res>? get job;

}
/// @nodoc
class __$JobSessionStateCopyWithImpl<$Res>
    implements _$JobSessionStateCopyWith<$Res> {
  __$JobSessionStateCopyWithImpl(this._self, this._then);

  final _JobSessionState _self;
  final $Res Function(_JobSessionState) _then;

/// Create a copy of JobSessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? job = freezed,Object? timeline = null,Object? isLoading = null,Object? isGenerating = null,Object? failure = freezed,}) {
  return _then(_JobSessionState(
job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Job?,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TimelineItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isGenerating: null == isGenerating ? _self.isGenerating : isGenerating // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

/// Create a copy of JobSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobCopyWith<$Res>? get job {
    if (_self.job == null) {
    return null;
  }

  return $JobCopyWith<$Res>(_self.job!, (value) {
    return _then(_self.copyWith(job: value));
  });
}
}

// dart format on
