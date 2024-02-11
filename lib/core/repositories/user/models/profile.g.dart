// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      myFishTanks: (json['myFishTanks'] as List<dynamic>?)
          ?.map((e) => MyFishTank.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'myFishTanks': instance.myFishTanks?.map((e) => e.toJson()).toList(),
    };
