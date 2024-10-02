import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'speed_limit_bloc.dart';

@immutable
class SpeedLimitState extends Equatable {
  const SpeedLimitState({
    required this.allSpeedLimits,
    this.selectedSpeedLimit,
  });

  final Map<VehicleWithSpeedLimit, ItemSpeed> allSpeedLimits;
  final VehicleWithSpeedLimit? selectedSpeedLimit;

  @override
  List<Object?> get props => [allSpeedLimits, selectedSpeedLimit];

  SpeedLimitState copyWith({
    Map<VehicleWithSpeedLimit, ItemSpeed>? allSpeedLimits,
    VehicleWithSpeedLimit? selectedSpeedLimit,
  }) {
    return SpeedLimitState(
      allSpeedLimits: allSpeedLimits ?? this.allSpeedLimits,
      selectedSpeedLimit: selectedSpeedLimit ?? this.selectedSpeedLimit,
    );
  }
}
