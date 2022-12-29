// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeState {
  String get successJoinRoom => throw _privateConstructorUsedError;
  bool get isClickedEntryButton => throw _privateConstructorUsedError;
  String get matchingMessage => throw _privateConstructorUsedError;
  String get connectClientCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {String successJoinRoom,
      bool isClickedEntryButton,
      String matchingMessage,
      String connectClientCount});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? successJoinRoom = null,
    Object? isClickedEntryButton = null,
    Object? matchingMessage = null,
    Object? connectClientCount = null,
  }) {
    return _then(_value.copyWith(
      successJoinRoom: null == successJoinRoom
          ? _value.successJoinRoom
          : successJoinRoom // ignore: cast_nullable_to_non_nullable
              as String,
      isClickedEntryButton: null == isClickedEntryButton
          ? _value.isClickedEntryButton
          : isClickedEntryButton // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$_HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$$_HomeStateCopyWith(
          _$_HomeState value, $Res Function(_$_HomeState) then) =
      __$$_HomeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String successJoinRoom,
      bool isClickedEntryButton,
      String matchingMessage,
      String connectClientCount});
}

/// @nodoc
class __$$_HomeStateCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$_HomeState>
    implements _$$_HomeStateCopyWith<$Res> {
  __$$_HomeStateCopyWithImpl(
      _$_HomeState _value, $Res Function(_$_HomeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? successJoinRoom = null,
    Object? isClickedEntryButton = null,
    Object? matchingMessage = null,
    Object? connectClientCount = null,
  }) {
    return _then(_$_HomeState(
      successJoinRoom: null == successJoinRoom
          ? _value.successJoinRoom
          : successJoinRoom // ignore: cast_nullable_to_non_nullable
              as String,
      isClickedEntryButton: null == isClickedEntryButton
          ? _value.isClickedEntryButton
          : isClickedEntryButton // ignore: cast_nullable_to_non_nullable
              as bool,
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

class _$_HomeState implements _HomeState {
  const _$_HomeState(
      {this.successJoinRoom = "",
      this.isClickedEntryButton = false,
      this.matchingMessage = "マッチング中………",
      this.connectClientCount = "0人"});

  @override
  @JsonKey()
  final String successJoinRoom;
  @override
  @JsonKey()
  final bool isClickedEntryButton;
  @override
  @JsonKey()
  final String matchingMessage;
  @override
  @JsonKey()
  final String connectClientCount;

  @override
  String toString() {
    return 'HomeState(successJoinRoom: $successJoinRoom, isClickedEntryButton: $isClickedEntryButton, matchingMessage: $matchingMessage, connectClientCount: $connectClientCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeState &&
            (identical(other.successJoinRoom, successJoinRoom) ||
                other.successJoinRoom == successJoinRoom) &&
            (identical(other.isClickedEntryButton, isClickedEntryButton) ||
                other.isClickedEntryButton == isClickedEntryButton) &&
            (identical(other.matchingMessage, matchingMessage) ||
                other.matchingMessage == matchingMessage) &&
            (identical(other.connectClientCount, connectClientCount) ||
                other.connectClientCount == connectClientCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, successJoinRoom,
      isClickedEntryButton, matchingMessage, connectClientCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      __$$_HomeStateCopyWithImpl<_$_HomeState>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final String successJoinRoom,
      final bool isClickedEntryButton,
      final String matchingMessage,
      final String connectClientCount}) = _$_HomeState;

  @override
  String get successJoinRoom;
  @override
  bool get isClickedEntryButton;
  @override
  String get matchingMessage;
  @override
  String get connectClientCount;
  @override
  @JsonKey(ignore: true)
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}
