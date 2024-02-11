// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  List<MyFishTank>? get myFishTanks => throw _privateConstructorUsedError;
  MyFishTank? get currentFishTank => throw _privateConstructorUsedError;
  SmartFishTank? get fishTankState => throw _privateConstructorUsedError;

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
      {List<MyFishTank>? myFishTanks,
      MyFishTank? currentFishTank,
      SmartFishTank? fishTankState});

  $MyFishTankCopyWith<$Res>? get currentFishTank;
  $SmartFishTankCopyWith<$Res>? get fishTankState;
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
    Object? myFishTanks = freezed,
    Object? currentFishTank = freezed,
    Object? fishTankState = freezed,
  }) {
    return _then(_value.copyWith(
      myFishTanks: freezed == myFishTanks
          ? _value.myFishTanks
          : myFishTanks // ignore: cast_nullable_to_non_nullable
              as List<MyFishTank>?,
      currentFishTank: freezed == currentFishTank
          ? _value.currentFishTank
          : currentFishTank // ignore: cast_nullable_to_non_nullable
              as MyFishTank?,
      fishTankState: freezed == fishTankState
          ? _value.fishTankState
          : fishTankState // ignore: cast_nullable_to_non_nullable
              as SmartFishTank?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MyFishTankCopyWith<$Res>? get currentFishTank {
    if (_value.currentFishTank == null) {
      return null;
    }

    return $MyFishTankCopyWith<$Res>(_value.currentFishTank!, (value) {
      return _then(_value.copyWith(currentFishTank: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SmartFishTankCopyWith<$Res>? get fishTankState {
    if (_value.fishTankState == null) {
      return null;
    }

    return $SmartFishTankCopyWith<$Res>(_value.fishTankState!, (value) {
      return _then(_value.copyWith(fishTankState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<MyFishTank>? myFishTanks,
      MyFishTank? currentFishTank,
      SmartFishTank? fishTankState});

  @override
  $MyFishTankCopyWith<$Res>? get currentFishTank;
  @override
  $SmartFishTankCopyWith<$Res>? get fishTankState;
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myFishTanks = freezed,
    Object? currentFishTank = freezed,
    Object? fishTankState = freezed,
  }) {
    return _then(_$HomeStateImpl(
      myFishTanks: freezed == myFishTanks
          ? _value._myFishTanks
          : myFishTanks // ignore: cast_nullable_to_non_nullable
              as List<MyFishTank>?,
      currentFishTank: freezed == currentFishTank
          ? _value.currentFishTank
          : currentFishTank // ignore: cast_nullable_to_non_nullable
              as MyFishTank?,
      fishTankState: freezed == fishTankState
          ? _value.fishTankState
          : fishTankState // ignore: cast_nullable_to_non_nullable
              as SmartFishTank?,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl(
      {final List<MyFishTank>? myFishTanks,
      this.currentFishTank,
      this.fishTankState})
      : _myFishTanks = myFishTanks;

  final List<MyFishTank>? _myFishTanks;
  @override
  List<MyFishTank>? get myFishTanks {
    final value = _myFishTanks;
    if (value == null) return null;
    if (_myFishTanks is EqualUnmodifiableListView) return _myFishTanks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final MyFishTank? currentFishTank;
  @override
  final SmartFishTank? fishTankState;

  @override
  String toString() {
    return 'HomeState(myFishTanks: $myFishTanks, currentFishTank: $currentFishTank, fishTankState: $fishTankState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            const DeepCollectionEquality()
                .equals(other._myFishTanks, _myFishTanks) &&
            (identical(other.currentFishTank, currentFishTank) ||
                other.currentFishTank == currentFishTank) &&
            (identical(other.fishTankState, fishTankState) ||
                other.fishTankState == fishTankState));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_myFishTanks),
      currentFishTank,
      fishTankState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final List<MyFishTank>? myFishTanks,
      final MyFishTank? currentFishTank,
      final SmartFishTank? fishTankState}) = _$HomeStateImpl;

  @override
  List<MyFishTank>? get myFishTanks;
  @override
  MyFishTank? get currentFishTank;
  @override
  SmartFishTank? get fishTankState;
  @override
  @JsonKey(ignore: true)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
