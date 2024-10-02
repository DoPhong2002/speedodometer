import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../gen/assets.gen.dart';

part 'trip_model.freezed.dart';

part 'trip_model.g.dart';

final List<TripModel> trips = [
  TripModel(
    id: 1,
    finish: '11:30 - 24/08/2024',
    from: [10.762622, 106.660172],
    to: [10.762622, 106.660172],
    distance: 1000,
    maxSpeed: 100,
    avgSpeed: 50,
    start: '11:30 - 24/08/2024',
    pathImage: Assets.images.map.normal.path,
    totalTime: 1000,
  ),
  TripModel(
    id: 2,
    finish: '11:30 - 24/08/2024',
    from: [10.762622, 106.660172],
    to: [10.762622, 106.660172],
    distance: 1000,
    maxSpeed: 100,
    avgSpeed: 50,
    start: '11:30 - 24/08/2024',
    pathImage: Assets.images.map.normal.path,
    totalTime: 1000,
  ),
  TripModel(
    id: 3,
    finish: '11:30 - 24/08/2024',
    from: [10.762622, 106.660172],
    to: [10.762622, 106.660172],
    distance: 1000,
    maxSpeed: 100,
    avgSpeed: 50,
    start: '11:30 - 24/08/2024',
    pathImage: Assets.images.map.normal.path,
    totalTime: 1000,
  ),
];

@freezed
class TripModel with _$TripModel {
  const factory TripModel({
    @Default(-1) int id,
    required String finish,
    required List<double> from,
    required List<double> to,
    required double distance,
    required double maxSpeed,
    required double avgSpeed,
    required String start,
    required String pathImage,
    required int totalTime,
  }) = _TripModel;

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);
}
