part of 'setting_bloc.dart';

@immutable
class SettingState extends Equatable {
  const SettingState({
    required this.speedUnit,
    required this.vehicle,
    required this.distanceUnit,
    required this.fontType,
    required this.rotate,
    required this.indexUnit,
  });

  final String speedUnit;
  final int indexUnit;
  final int vehicle;
  final String distanceUnit;
  final int fontType;
  final bool rotate;

  SettingState copyWith({
    String? speedUnit,
    int? vehicle,
    String? distanceUnit,
    int? fontType,
    bool? rotate,
    int? indexUnit,
  }) {
    return SettingState(
      speedUnit: speedUnit ?? this.speedUnit,
      vehicle: vehicle ?? this.vehicle,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      fontType: fontType ?? this.fontType,
      rotate: rotate ?? this.rotate,
      indexUnit: indexUnit ?? this.indexUnit,
    );
  }

  @override
  List<Object?> get props => [
        speedUnit,
        vehicle,
        distanceUnit,
        fontType,
        rotate,
        indexUnit,
      ];
}
