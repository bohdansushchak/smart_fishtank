// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_fish_tank_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SmartFishTankStateImpl _$$SmartFishTankStateImplFromJson(
        Map<String, dynamic> json) =>
    _$SmartFishTankStateImpl(
      socket1: json['socket1'] == null
          ? null
          : SocketState.fromJson(json['socket1'] as Map<String, dynamic>),
      socket2: json['socket2'] == null
          ? null
          : SocketState.fromJson(json['socket2'] as Map<String, dynamic>),
      socket3: json['socket3'] == null
          ? null
          : SocketState.fromJson(json['socket3'] as Map<String, dynamic>),
      socket4: json['socket4'] == null
          ? null
          : SocketState.fromJson(json['socket4'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SmartFishTankStateImplToJson(
        _$SmartFishTankStateImpl instance) =>
    <String, dynamic>{
      'socket1': instance.socket1?.toJson(),
      'socket2': instance.socket2?.toJson(),
      'socket3': instance.socket3?.toJson(),
      'socket4': instance.socket4?.toJson(),
    };

_$SocketStateImpl _$$SocketStateImplFromJson(Map<String, dynamic> json) =>
    _$SocketStateImpl(
      isOn: json['isOn'] as bool,
      force: json['force'] as bool?,
    );

Map<String, dynamic> _$$SocketStateImplToJson(_$SocketStateImpl instance) =>
    <String, dynamic>{
      'isOn': instance.isOn,
      'force': instance.force,
    };
