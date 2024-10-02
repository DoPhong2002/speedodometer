import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:injectable/injectable.dart';

import '../../../../utils/direction_utils.dart';

class CompassState {
  CompassState({this.direction, this.angle = 'East 0°', this.hasError = false});
  final double? direction;
  final String angle;
  final bool hasError;
}

@singleton
class CompassCubit extends Cubit<CompassState> {
  CompassCubit() : super(CompassState()) {
    _initializeCompass();
  }

  StreamSubscription<CompassEvent>? _compassSubscription;

  void _initializeCompass() {
    _compassSubscription = FlutterCompass.events?.listen((CompassEvent event) {
      if (event.heading == null) {
        emit(CompassState(hasError: true));
      } else {
        final direction = event.heading!;
        final angle = _getFormattedAngle(direction, event);
        emit(CompassState(direction: direction, angle: angle));
      }
    });
  }

  String _getFormattedAngle(double angle, CompassEvent event) {
    final String direction = angle.getDirection;
    return direction;
  }

  @override
  Future<void> close() {
    _compassSubscription?.cancel();
    return super.close();
  }
}
