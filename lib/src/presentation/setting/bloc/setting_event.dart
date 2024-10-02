part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object?> get props => [];
}

class SettingInitEvent extends SettingEvent {
  const SettingInitEvent();
}

class SpeedUnitEvent extends SettingEvent {
  const SpeedUnitEvent(this.unit);

  final Unit unit;

  @override
  List<Object?> get props => [unit];
}

class VehicleEvent extends SettingEvent {
  const VehicleEvent(this.vehicle);

  final int vehicle;

  @override
  List<Object?> get props => [vehicle];
}

class DistanceUnitEvent extends SettingEvent {
  const DistanceUnitEvent(this.unit);

  final Unit unit;

  @override
  List<Object?> get props => [unit];
}

class FontTypeEvent extends SettingEvent {
  const FontTypeEvent(this.fontType);

  final FontStyle fontType;

  @override
  List<Object?> get props => [fontType];
}

class RotateEvent extends SettingEvent {
  const RotateEvent(this.rotate);

  final bool rotate;

  @override
  List<Object?> get props => [rotate];
}
