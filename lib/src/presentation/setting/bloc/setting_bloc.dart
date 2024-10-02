import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../data/local/shared_preferences_manager.dart';
import '../../../shared/extension/context_extension.dart';

part 'setting_event.dart';

part 'setting_state.dart';

enum Unit {
  km('Km/h', 'Km'),
  mi('Mp/h', 'Mi'),
  nmi('Knot', 'Nmi');

  const Unit(this.speedUnit, this.distanceUnit);

  final String speedUnit;
  final String distanceUnit;
}

enum FontStyle { normal, digital }

extension FontExtension on FontStyle {
  String font(BuildContext context) =>
      this == FontStyle.normal ? context.l10n.normal : context.l10n.digital;
}


@singleton
class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc()
      : super(SettingState(
          speedUnit: Unit.km.speedUnit,
          vehicle: 0,
          distanceUnit: Unit.km.distanceUnit,
          fontType: 0,
          rotate: false,
          indexUnit: 0,
        )) {
    on<SettingInitEvent>(_initEvent);
    on<SpeedUnitEvent>(_speedUnitEvent);
    on<VehicleEvent>(vehicleEvent);
    on<DistanceUnitEvent>(_distanceUnitEvent);
    on<FontTypeEvent>(_fontTypeEvent);
    on<RotateEvent>(_rotateEvent);
  }

  Future _initEvent(
    SettingInitEvent event,
    Emitter<SettingState> emit,
  ) async {
    final speedUnit = await PreferenceManager.getSpeedUnit();
    final vehicle = await PreferenceManager.getVehicle();
    final distanceUnit = await PreferenceManager.getDistanceUnit();
    final fontType = await PreferenceManager.getFontType();
    final rotate = await PreferenceManager.getRotate();
    final int indexUnit = Unit.values
        .indexWhere((element) => element.distanceUnit == distanceUnit);
    if (indexUnit != -1) {
      emit(state.copyWith(
        indexUnit: indexUnit,
      ));
    }
    emit(state.copyWith(
        speedUnit: speedUnit,
        vehicle: vehicle,
        distanceUnit: distanceUnit,
        fontType: fontType,
        rotate: rotate));
  }

  FutureOr<void> _speedUnitEvent(
      SpeedUnitEvent event, Emitter<SettingState> emit) async {
    PreferenceManager.setSpeedUnit(event.unit.speedUnit);
    PreferenceManager.setDistanceUnit(event.unit.distanceUnit);
    int index = Unit.values.indexWhere((element) => element == event.unit);
    if (index != -1) {
      emit(state.copyWith(indexUnit: index));
    }
    emit(state.copyWith(
      speedUnit: event.unit.speedUnit,
      distanceUnit: event.unit.distanceUnit,
    ));
  }

  FutureOr<void> vehicleEvent(
      VehicleEvent event, Emitter<SettingState> emit) async {
    PreferenceManager.setVehicle(event.vehicle);
    emit(state.copyWith(
      vehicle: event.vehicle,
    ));
  }

  FutureOr<void> _distanceUnitEvent(
      DistanceUnitEvent event, Emitter<SettingState> emit) async {
    PreferenceManager.setDistanceUnit(event.unit.distanceUnit);
    PreferenceManager.setSpeedUnit(event.unit.speedUnit);
    emit(state.copyWith(
      distanceUnit: event.unit.distanceUnit,
      speedUnit: event.unit.speedUnit,
    ));
  }

  FutureOr<void> _fontTypeEvent(
      FontTypeEvent event, Emitter<SettingState> emit) async {
    PreferenceManager.setFontType(event.fontType == FontStyle.normal ? 0 : 1);
    emit(state.copyWith(
      fontType: event.fontType == FontStyle.normal ? 0 : 1,
    ));
  }

  FutureOr<void> _rotateEvent(
      RotateEvent event, Emitter<SettingState> emit) async {
    PreferenceManager.setRotate(event.rotate);
    emit(state.copyWith(
      rotate: event.rotate,
    ));
  }
}
