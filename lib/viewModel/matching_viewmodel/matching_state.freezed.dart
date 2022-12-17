// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'matching_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MatchingState {
  String get successJoinRoom => throw _privateConstructorUsedError;
  String get matchingMessage => throw _privateConstructorUsedError;
  String get connectClientCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MatchingStateCopyWith<MatchingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchingStateCopyWith<$Res> {
  factory $MatchingStateCopyWith(
          MatchingState value, $Res Function(MatchingState) then) =
      _$MatchingStateCopyWithImpl<$Res, MatchingState>;
  @useResult
  $Res call(
      {String successJoinRoom,
      String matchingMessage,
      String connectClientCount});
}

/// @nodoc
class _$MatchingStateCopyWithImpl<$Res, $Val extends MatchingState>
    implements $MatchingStateCopyWith<$Res> {
  _$MatchingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? successJoinRoom = null,
    Object? matchingMessage = null,
    Object? connectClientCount = null,
  }) {
    return _then(_value.copyWith(
      successJoinRoom: null == successJoinRoom
          ? _value.successJoinRoom
          : successJoinRoom // ignore: cast_nullable_to_non_nullable
              as String,
      matchingMessage: null == matchingMessage
          ? _value.matchingMessage
          : matchingMessage // ignore: cast_nullable_to_non_nullable
              as String,
      connectClientCount: null == connectClientCount
          ? _value.connectClientCount
          : connectClientCount // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MatchingStateCopyWith<$Res>
    implements $MatchingStateCopyWith<$Res> {
  factory _$$_MatchingStateCopyWith(
          _$_MatchingState value, $Res Function(_$_MatchingState) then) =
      __$$_MatchingStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String successJoinRoom,
      String matchingMessage,
      String connectClientCount});
}

/// @nodoc
class __$$_MatchingStateCopyWithImpl<$Res>
    extends _$MatchingStateCopyWithImpl<$Res, _$_MatchingState>
    implements _$$_MatchingStateCopyWith<$Res> {
  __$$_MatchingStateCopyWithImpl(
      _$_MatchingState _value, $Res Function(_$_MatchingState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? successJoinRoom = null,
    Object? matchingMessage = null,
    Object? connectClientCount = null,
  }) {
    return _then(_$_MatchingState(
      successJoinRoom: null == successJoinRoom
          ? _value.successJoinRoom
          : successJoinRoom // ignore: cast_nullable_to_non_nullable
              as String,
      matchingMessage: null == matchingMessage
          ? _value.matchingMessage
          : matchingMessage // ignore: cast_nullable_to_non_nullable
              as String,
      connectClientCount: null == connectClientCount
          ? _value.connectClientCount
          : connectClientCount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_MatchingState implements _MatchingState {
  const _$_MatchingState(
      {this.successJoinRoom = "",
      this.matchingMessage = "マッチング中………",
      this.connectClientCount = "0人"});

  @override
  @JsonKey()
  final String successJoinRoom;
  @override
  @JsonKey()
  final String matchingMessage;
  @override
  @JsonKey()
  final String connectClientCount;

  @override
  String toString() {
    return 'MatchingState(successJoinRoom: $successJoinRoom, matchingMessage: $matchingMessage, connectClientCount: $connectClientCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MatchingState &&
            (identical(other.successJoinRoom, successJoinRoom) ||
                other.successJoinRoom == successJoinRoom) &&
            (identical(other.matchingMessage, matchingMessage) ||
                other.matchingMessage == matchingMessage) &&
            (identical(other.connectClientCount, connectClientCount) ||
                other.connectClientCount == connectClientCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, successJoinRoom, matchingMessage, connectClientCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MatchingStateCopyWith<_$_MatchingState> get copyWith =>
      __$$_MatchingStateCopyWithImpl<_$_MatchingState>(this, _$identity);
}

abstract class _MatchingState implements MatchingState {
  const factory _MatchingState(
      {final String successJoinRoom,
      final String matchingMessage,
      final String connectClientCount}) = _$_MatchingState;

  @override
  String get successJoinRoom;
  @override
  String get matchingMessage;
  @override
  String get connectClientCount;
  @override
  @JsonKey(ignore: true)
  _$$_MatchingStateCopyWith<_$_MatchingState> get copyWith =>
      throw _privateConstructorUsedError;
}
