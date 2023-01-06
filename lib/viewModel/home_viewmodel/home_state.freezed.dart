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
  bool get isClickedEntryButton => throw _privateConstructorUsedError;
  int get icon => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String get lifeUpTime => throw _privateConstructorUsedError;
  int get lifeCount => throw _privateConstructorUsedError;

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
      {bool isClickedEntryButton,
      int icon,
      String nickname,
      String lifeUpTime,
      int lifeCount});
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
    Object? isClickedEntryButton = null,
    Object? icon = null,
    Object? nickname = null,
    Object? lifeUpTime = null,
    Object? lifeCount = null,
  }) {
    return _then(_value.copyWith(
      isClickedEntryButton: null == isClickedEntryButton
          ? _value.isClickedEntryButton
          : isClickedEntryButton // ignore: cast_nullable_to_non_nullable
              as bool,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      lifeUpTime: null == lifeUpTime
          ? _value.lifeUpTime
          : lifeUpTime // ignore: cast_nullable_to_non_nullable
              as String,
      lifeCount: null == lifeCount
          ? _value.lifeCount
          : lifeCount // ignore: cast_nullable_to_non_nullable
              as int,
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
      {bool isClickedEntryButton,
      int icon,
      String nickname,
      String lifeUpTime,
      int lifeCount});
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
    Object? isClickedEntryButton = null,
    Object? icon = null,
    Object? nickname = null,
    Object? lifeUpTime = null,
    Object? lifeCount = null,
  }) {
    return _then(_$_HomeState(
      isClickedEntryButton: null == isClickedEntryButton
          ? _value.isClickedEntryButton
          : isClickedEntryButton // ignore: cast_nullable_to_non_nullable
              as bool,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      lifeUpTime: null == lifeUpTime
          ? _value.lifeUpTime
          : lifeUpTime // ignore: cast_nullable_to_non_nullable
              as String,
      lifeCount: null == lifeCount
          ? _value.lifeCount
          : lifeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_HomeState implements _HomeState {
  const _$_HomeState(
      {this.isClickedEntryButton = false,
      this.icon = 0,
      this.nickname = "name",
      this.lifeUpTime = "",
      this.lifeCount = 0});

  @override
  @JsonKey()
  final bool isClickedEntryButton;
  @override
  @JsonKey()
  final int icon;
  @override
  @JsonKey()
  final String nickname;
  @override
  @JsonKey()
  final String lifeUpTime;
  @override
  @JsonKey()
  final int lifeCount;

  @override
  String toString() {
    return 'HomeState(isClickedEntryButton: $isClickedEntryButton, icon: $icon, nickname: $nickname, lifeUpTime: $lifeUpTime, lifeCount: $lifeCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeState &&
            (identical(other.isClickedEntryButton, isClickedEntryButton) ||
                other.isClickedEntryButton == isClickedEntryButton) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.lifeUpTime, lifeUpTime) ||
                other.lifeUpTime == lifeUpTime) &&
            (identical(other.lifeCount, lifeCount) ||
                other.lifeCount == lifeCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isClickedEntryButton, icon, nickname, lifeUpTime, lifeCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      __$$_HomeStateCopyWithImpl<_$_HomeState>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final bool isClickedEntryButton,
      final int icon,
      final String nickname,
      final String lifeUpTime,
      final int lifeCount}) = _$_HomeState;

  @override
  bool get isClickedEntryButton;
  @override
  int get icon;
  @override
  String get nickname;
  @override
  String get lifeUpTime;
  @override
  int get lifeCount;
  @override
  @JsonKey(ignore: true)
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}
