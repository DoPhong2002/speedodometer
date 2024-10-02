// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripModelImpl _$$TripModelImplFromJson(Map<String, dynamic> json) =>
    _$TripModelImpl(
      id: (json['id'] as num?)?.toInt() ?? -1,
      finish: json['finish'] as String,
      from: (json['from'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      to: (json['to'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      distance: (json['distance'] as num).toDouble(),
      maxSpeed: (json['maxSpeed'] as num).toDouble(),
      avgSpeed: (json['avgSpeed'] as num).toDouble(),
      start: json['start'] as String,
      pathImage: json['pathImage'] as String,
      totalTime: (json['totalTime'] as num).toInt(),
    );

Map<String, dynamic> _$$TripModelImplToJson(_$TripModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'finish': instance.finish,
      'from': instance.from,
      'to': instance.to,
      'distance': instance.distance,
      'maxSpeed': instance.maxSpeed,
      'avgSpeed': instance.avgSpeed,
      'start': instance.start,
      'pathImage': instance.pathImage,
      'totalTime': instance.totalTime,
    };
