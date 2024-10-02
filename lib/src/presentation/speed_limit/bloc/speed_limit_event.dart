import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'speed_limit_bloc.dart';

@immutable
abstract class SpeedLimitEvent extends Equatable {}

class SpeedInitEvent extends SpeedLimitEvent {
  @override
  List<Object?> get props => [];
}

class SpeedInputEvent extends SpeedLimitEvent {
  SpeedInputEvent({
    required this.vehicleType,
    required this.inputSpeed,
    required this.index,
  });

  final VehicleWithSpeedLimit vehicleType;
  final String inputSpeed;
  final int index;

  @override
  List<Object?> get props => [vehicleType, inputSpeed, index];
}
