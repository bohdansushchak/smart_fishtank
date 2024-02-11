// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_fish_tank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SmartFishTankImpl _$$SmartFishTankImplFromJson(Map<String, dynamic> json) =>
    _$SmartFishTankImpl(
      settings: json['settings'] == null
          ? null
          : SmartFishTankSettings.fromJson(
              json['settings'] as Map<String, dynamic>),
      state: json['state'] == null
          ? null
          : SmartFishTankState.fromJson(json['state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SmartFishTankImplToJson(_$SmartFishTankImpl instance) =>
    <String, dynamic>{
      'settings': instance.settings?.toJson(),
      'state': instance.state?.toJson(),
    };
