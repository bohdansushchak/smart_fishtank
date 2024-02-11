// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_fish_tank.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MyFishTank _$MyFishTankFromJson(Map<String, dynamic> json) {
  return _MyFishTank.fromJson(json);
}

/// @nodoc
mixin _$MyFishTank {
  String get name => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyFishTankCopyWith<MyFishTank> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyFishTankCopyWith<$Res> {
  factory $MyFishTankCopyWith(
          MyFishTank value, $Res Function(MyFishTank) then) =
      _$MyFishTankCopyWithImpl<$Res, MyFishTank>;
  @useResult
  $Res call({String name, String uid});
}

/// @nodoc
class _$MyFishTankCopyWithImpl<$Res, $Val extends MyFishTank>
    implements $MyFishTankCopyWith<$Res> {
  _$MyFishTankCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? uid = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyFishTankImplCopyWith<$Res>
    implements $MyFishTankCopyWith<$Res> {
  factory _$$MyFishTankImplCopyWith(
          _$MyFishTankImpl value, $Res Function(_$MyFishTankImpl) then) =
      __$$MyFishTankImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String uid});
}

/// @nodoc
class __$$MyFishTankImplCopyWithImpl<$Res>
    extends _$MyFishTankCopyWithImpl<$Res, _$MyFishTankImpl>
    implements _$$MyFishTankImplCopyWith<$Res> {
  __$$MyFishTankImplCopyWithImpl(
      _$MyFishTankImpl _value, $Res Function(_$MyFishTankImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? uid = null,
  }) {
    return _then(_$MyFishTankImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MyFishTankImpl implements _MyFishTank {
  const _$MyFishTankImpl(this.name, this.uid);

  factory _$MyFishTankImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyFishTankImplFromJson(json);

  @override
  final String name;
  @override
  final String uid;

  @override
  String toString() {
    return 'MyFishTank(name: $name, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyFishTankImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyFishTankImplCopyWith<_$MyFishTankImpl> get copyWith =>
      __$$MyFishTankImplCopyWithImpl<_$MyFishTankImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyFishTankImplToJson(
      this,
    );
  }
}

abstract class _MyFishTank implements MyFishTank {
  const factory _MyFishTank(final String name, final String uid) =
      _$MyFishTankImpl;

  factory _MyFishTank.fromJson(Map<String, dynamic> json) =
      _$MyFishTankImpl.fromJson;

  @override
  String get name;
  @override
  String get uid;
  @override
  @JsonKey(ignore: true)
  _$$MyFishTankImplCopyWith<_$MyFishTankImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
