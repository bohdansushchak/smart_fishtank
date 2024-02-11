// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_fish_tank_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SmartFishTankSettingsImpl _$$SmartFishTankSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$SmartFishTankSettingsImpl(
      socket1: json['socket1'] == null
          ? null
          : SmartFishTankSocketSettings.fromJson(
              json['socket1'] as Map<String, dynamic>),
      socket2: json['socket2'] == null
          ? null
          : SmartFishTankSocketSettings.fromJson(
              json['socket2'] as Map<String, dynamic>),
      socket3: json['socket3'] == null
          ? null
          : SmartFishTankSocketSettings.fromJson(
              json['socket3'] as Map<String, dynamic>),
      socket4: json['socket4'] == null
          ? null
          : SmartFishTankSocketSettings.fromJson(
              json['socket4'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SmartFishTankSettingsImplToJson(
        _$SmartFishTankSettingsImpl instance) =>
    <String, dynamic>{
      'socket1': instance.socket1?.toJson(),
      'socket2': instance.socket2?.toJson(),
      'socket3': instance.socket3?.toJson(),
      'socket4': instance.socket4?.toJson(),
    };

_$SmartFishTankSocketSettingsImpl _$$SmartFishTankSocketSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$SmartFishTankSocketSettingsImpl(
      type: $enumDecode(_$SocketTypeEnumMap, json['type']),
      fromHourUtc: json['fromHourUtc'] as int,
      fromMinUtc: json['fromMinUtc'] as int,
      toHourUtc: json['toHourUtc'] as int,
      toMinUtc: json['toMinUtc'] as int,
    );

Map<String, dynamic> _$$SmartFishTankSocketSettingsImplToJson(
        _$SmartFishTankSocketSettingsImpl instance) =>
    <String, dynamic>{
      'type': _$SocketTypeEnumMap[instance.type]!,
      'fromHourUtc': instance.fromHourUtc,
      'fromMinUtc': instance.fromMinUtc,
      'toHourUtc': instance.toHourUtc,
      'toMinUtc': instance.toMinUtc,
    };

const _$SocketTypeEnumMap = {
  SocketType.light: 'light',
  SocketType.uv: 'uv',
  SocketType.co2: 'co2',
  SocketType.airPump: 'airPump',
};
