import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@singleton
class SpeedCubit extends Cubit<SpeedState> {
  SpeedCubit()
      : super(const SpeedState(
          maxSpeedOnTime: 0,
          speed: 0,
          speedWarning: SpeedWarning.none,
          speedLimit: 9999,
          distanceTravelled: 0,
        ));

  Position? _lastPosition;
  StreamSubscription<Position>? _positionStreamSubscription;

  Future<void> startTracking() async {
    await _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      ),
    ).listen((Position position) {
      final speed = position.speed;

      double distanceTravelled = state.distanceTravelled;
      if (_lastPosition != null) {
        distanceTravelled += Geolocator.distanceBetween(
          _lastPosition!.latitude,
          _lastPosition!.longitude,
          position.latitude,
          position.longitude,
        );
      }
      _lastPosition = position;

      change(maxSpeed: state.maxSpeedOnTime, speed: speed);
      emit(state.copyWith(distanceTravelled: distanceTravelled));
    });
  }

  void change({required double maxSpeed, required double speed}) {
    if (speed >= state.speedLimit - 1) {
      emit(state.copyWith(speedWarning: SpeedWarning.red));
    } else if (speed >= state.speedLimit - 10) {
      emit(state.copyWith(speedWarning: SpeedWarning.orange));
    } else {
      emit(state.copyWith(speedWarning: SpeedWarning.none));
    }
    final updatedMaxSpeed = speed > maxSpeed ? speed : maxSpeed;
    emit(state.copyWith(maxSpeedOnTime: updatedMaxSpeed, speed: speed));
  }

  void stopTracking() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    emit(state.copyWith(
      maxSpeedOnTime: 0,
      speed: 0,
      distanceTravelled: 0,
      speedWarning: SpeedWarning.none,
    ));
  }

  void pauseTracking() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    emit(state.copyWith(
      speed: 0,
      speedWarning: SpeedWarning.none,
    ));
  }

  void updateSpeedLimit(double speedLimit) {
    emit(state.copyWith(speedLimit: speedLimit));
  }

  void updateSpeed(double speed) {
    emit(state.copyWith(speed: speed));
  }
}

class SpeedState extends Equatable {
  const SpeedState({
    required this.maxSpeedOnTime,
    required this.speed,
    required this.speedWarning,
    required this.speedLimit,
    required this.distanceTravelled,
  });

  final double maxSpeedOnTime;
  final double speedLimit;
  final double speed;
  final SpeedWarning speedWarning;
  final double distanceTravelled;

  @override
  List<Object?> get props =>
      [maxSpeedOnTime, speed, speedWarning, speedLimit, distanceTravelled];

  SpeedState copyWith({
    double? maxSpeedOnTime,
    double? speed,
    SpeedWarning? speedWarning,
    double? speedLimit,
    double? distanceTravelled,
  }) {
    return SpeedState(
      maxSpeedOnTime: maxSpeedOnTime ?? this.maxSpeedOnTime,
      speedLimit: speedLimit ?? this.speedLimit,
      speed: speed ?? this.speed,
      speedWarning: speedWarning ?? this.speedWarning,
      distanceTravelled: distanceTravelled ?? this.distanceTravelled,
    );
  }
}

enum SpeedWarning { none, orange, red }
