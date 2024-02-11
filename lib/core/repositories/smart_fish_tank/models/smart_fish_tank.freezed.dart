// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smart_fish_tank.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SmartFishTank _$SmartFishTankFromJson(Map<String, dynamic> json) {
  return _SmartFishTank.fromJson(json);
}

/// @nodoc
mixin _$SmartFishTank {
  SmartFishTankSettings? get settings => throw _privateConstructorUsedError;
  SmartFishTankState? get state => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SmartFishTankCopyWith<SmartFishTank> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmartFishTankCopyWith<$Res> {
  factory $SmartFishTankCopyWith(
          SmartFishTank value, $Res Function(SmartFishTank) then) =
      _$SmartFishTankCopyWithImpl<$Res, SmartFishTank>;
  @useResult
  $Res call({SmartFishTankSettings? settings, SmartFishTankState? state});

  $SmartFishTankSettingsCopyWith<$Res>? get settings;
  $SmartFishTankStateCopyWith<$Res>? get state;
}

/// @nodoc
class _$SmartFishTankCopyWithImpl<$Res, $Val extends SmartFishTank>
    implements $SmartFishTankCopyWith<$Res> {
  _$SmartFishTankCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = freezed,
    Object? state = freezed,
  }) {
    return _then(_value.copyWith(
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SmartFishTankSettings?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as SmartFishTankState?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SmartFishTankSettingsCopyWith<$Res>? get settings {
    if (_value.settings == null) {
      return null;
    }

    return $SmartFishTankSettingsCopyWith<$Res>(_value.settings!, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SmartFishTankStateCopyWith<$Res>? get state {
    if (_value.state == null) {
      return null;
    }

    return $SmartFishTankStateCopyWith<$Res>(_value.state!, (value) {
      return _then(_value.copyWith(state: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SmartFishTankImplCopyWith<$Res>
    implements $SmartFishTankCopyWith<$Res> {
  factory _$$SmartFishTankImplCopyWith(
          _$SmartFishTankImpl value, $Res Function(_$SmartFishTankImpl) then) =
      __$$SmartFishTankImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SmartFishTankSettings? settings, SmartFishTankState? state});

  @override
  $SmartFishTankSettingsCopyWith<$Res>? get settings;
  @override
  $SmartFishTankStateCopyWith<$Res>? get state;
}

/// @nodoc
class __$$SmartFishTankImplCopyWithImpl<$Res>
    extends _$SmartFishTankCopyWithImpl<$Res, _$SmartFishTankImpl>
    implements _$$SmartFishTankImplCopyWith<$Res> {
  __$$SmartFishTankImplCopyWithImpl(
      _$SmartFishTankImpl _value, $Res Function(_$SmartFishTankImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = freezed,
    Object? state = freezed,
  }) {
    return _then(_$SmartFishTankImpl(
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SmartFishTankSettings?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as SmartFishTankState?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$SmartFishTankImpl implements _SmartFishTank {
  const _$SmartFishTankImpl({this.settings, this.state});

  factory _$SmartFishTankImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmartFishTankImplFromJson(json);

  @override
  final SmartFishTankSettings? settings;
  @override
  final SmartFishTankState? state;

  @override
  String toString() {
    return 'SmartFishTank(settings: $settings, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartFishTankImpl &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, settings, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SmartFishTankImplCopyWith<_$SmartFishTankImpl> get copyWith =>
      __$$SmartFishTankImplCopyWithImpl<_$SmartFishTankImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmartFishTankImplToJson(
      this,
    );
  }
}

abstract class _SmartFishTank implements SmartFishTank {
  const factory _SmartFishTank(
      {final SmartFishTankSettings? settings,
      final SmartFishTankState? state}) = _$SmartFishTankImpl;

  factory _SmartFishTank.fromJson(Map<String, dynamic> json) =
      _$SmartFishTankImpl.fromJson;

  @override
  SmartFishTankSettings? get settings;
  @override
  SmartFishTankState? get state;
  @override
  @JsonKey(ignore: true)
  _$$SmartFishTankImplCopyWith<_$SmartFishTankImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
