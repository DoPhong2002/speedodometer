import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../config/di/di.dart';
import '../../../data/local/shared_preferences_manager.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/localization_util.dart';
import '../../map/cubit/speed_cubit.dart';
import '../../setting/bloc/setting_bloc.dart';
import 'speed_limit_event.dart';
import 'speed_limit_state.dart';

@singleton
class SpeedLimitBloc extends Bloc<SpeedLimitEvent, SpeedLimitState> {
  SpeedLimitBloc()
      : super(const SpeedLimitState(
            allSpeedLimits: <VehicleWithSpeedLimit, ItemSpeed>{})) {
    on<SpeedInputEvent>(_onSpeedInput);
    on<SpeedInitEvent>(_init);
  }

  Future<void> _init(
    SpeedInitEvent event,
    Emitter<SpeedLimitState> emit,
  ) async {
    final Map<VehicleWithSpeedLimit, ItemSpeed> speedLimitLocal =
        await PreferenceManager.getSpeedLimits();
    emit(state.copyWith(allSpeedLimits: speedLimitLocal));
  }

  Future<void> _onSpeedInput(
    SpeedInputEvent event,
    Emitter<SpeedLimitState> emit,
  ) async {
    final itemSpeed = state.allSpeedLimits[event.vehicleType];
    final inputSpeedDouble = double.tryParse(event.inputSpeed)?.toInt();
    if (inputSpeedDouble != null) {
      final isValid = inputSpeedDouble <= itemSpeed!.speedLimit;
      if (isValid && inputSpeedDouble > 0) {
        final updatedItem =
            itemSpeed.copyWith(validate: isValid, speed: inputSpeedDouble);
        final updatedMap =
        Map<VehicleWithSpeedLimit, ItemSpeed>.from(state.allSpeedLimits)
              ..[event.vehicleType] = updatedItem;
        emit(state.copyWith(
          allSpeedLimits: updatedMap,
          selectedSpeedLimit: event.vehicleType,
        ));
        await PreferenceManager.setSpeedLimits(state.allSpeedLimits);
        final vehicle = getIt<SettingBloc>().state.vehicle;
        if(vehicle == event.index) {
          getIt<SpeedCubit>().updateSpeedLimit(inputSpeedDouble.toDouble());
        }
      } else {
        final updatedItem = itemSpeed.copyWith(validate: false);
        final updatedMap =
            Map<VehicleWithSpeedLimit, ItemSpeed>.from(state.allSpeedLimits)
              ..[event.vehicleType] = updatedItem;
        emit(state.copyWith(
          allSpeedLimits: updatedMap,
          selectedSpeedLimit: event.vehicleType,
        ));
      }
    }
  }
}

class ItemSpeed {
  ItemSpeed({
    required this.path,
    required this.title,
    required this.validate,
    required this.speed,
    required this.speedLimit,
    required this.speedType,
  });

  factory ItemSpeed.fromJson(Map<String, dynamic> json) {
    final vehicle = VehicleWithSpeedLimit.values.firstWhere(
      (e) => e.value.path == json['path'],
      orElse: () => VehicleWithSpeedLimit.walking,
    );

    return ItemSpeed(
      path: json['path'],
      title: vehicle.value.title,
      validate: json['validate'],
      speed: json['speed'],
      speedLimit: json['speedLimit'],
      speedType:
          SpeedType.values.firstWhere((e) => e.toString() == json['speedType']),
    );
  }

  final String path;
  final String title;
  final bool validate;
  final int speed;
  final int speedLimit;
  final SpeedType speedType;

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'title': title,
      'validate': validate,
      'speed': speed,
      'speedLimit': speedLimit,
      'speedType': speedType.toString(),
    };
  }

  ItemSpeed copyWith({
    String? path,
    String? title,
    bool? validate,
    int? speed,
    int? speedLimit,
    SpeedType? speedType,
  }) {
    return ItemSpeed(
      path: path ?? this.path,
      title: title ?? this.title,
      validate: validate ?? this.validate,
      speed: speed ?? this.speed,
      speedLimit: speedLimit ?? this.speedLimit,
      speedType: this.speedType,
    );
  }
}

enum VehicleWithSpeedLimit {
  walking,
  bicycle,
  motorcycle,
  car,
  train,
  boat,
  airplane;

  ItemSpeed get value {
    switch (this) {
      case VehicleWithSpeedLimit.walking:
        return ItemSpeed(
            path: Assets.icons.dialog.walking.path,
            title: L10n.tr.walking,
            validate: true,
            speed: 15,
            speedLimit: 15,
            speedType: SpeedType.low);
      case VehicleWithSpeedLimit.bicycle:
        return ItemSpeed(
            path: Assets.icons.dialog.bicycle.path,
            title: L10n.tr.bicycle,
            validate: true,
            speed: 70,
            speedLimit: 70,
            speedType: SpeedType.low);

      case VehicleWithSpeedLimit.motorcycle:
        return ItemSpeed(
            path: Assets.icons.dialog.motorcycle.path,
            title: L10n.tr.motorcycle,
            validate: true,
            speed: 300,
            speedLimit: 300,
            speedType: SpeedType.medium);

      case VehicleWithSpeedLimit.car:
        return ItemSpeed(
            path: Assets.icons.dialog.car.path,
            title: L10n.tr.car,
            validate: true,
            speed: 400,
            speedLimit: 400,
            speedType: SpeedType.medium);

      case VehicleWithSpeedLimit.train:
        return ItemSpeed(
            path: Assets.icons.dialog.train.path,
            title: L10n.tr.train,
            validate: true,
            speed: 400,
            speedLimit: 400,
            speedType: SpeedType.medium);

      case VehicleWithSpeedLimit.boat:
        return ItemSpeed(
            path: Assets.icons.dialog.boat.path,
            title: L10n.tr.boat,
            validate: true,
            speed: 100,
            speedLimit: 100,
            speedType: SpeedType.low);

      case VehicleWithSpeedLimit.airplane:
        return ItemSpeed(
            path: Assets.icons.dialog.air.path,
            title: L10n.tr.air_plane,
            validate: true,
            speed: 2000,
            speedLimit: 2000,
            speedType: SpeedType.hight);
    }
  }

  static Map<VehicleWithSpeedLimit, ItemSpeed> loadSpeedLimits() {
    return {
      VehicleWithSpeedLimit.walking: VehicleWithSpeedLimit.walking.value,
      VehicleWithSpeedLimit.bicycle: VehicleWithSpeedLimit.bicycle.value,
      VehicleWithSpeedLimit.motorcycle: VehicleWithSpeedLimit.motorcycle.value,
      VehicleWithSpeedLimit.car: VehicleWithSpeedLimit.car.value,
      VehicleWithSpeedLimit.train: VehicleWithSpeedLimit.train.value,
      VehicleWithSpeedLimit.boat: VehicleWithSpeedLimit.boat.value,
      VehicleWithSpeedLimit.airplane: VehicleWithSpeedLimit.airplane.value,
    };
  }
}

enum SpeedType {
  low,
  hight,
  medium;

  static SpeedType value(int value) {
    switch (value) {
      case 0:
        return SpeedType.low;
      case 1:
        return SpeedType.low;
      case 2:
        return SpeedType.medium;
      case 3:
        return SpeedType.medium;
      case 4:
        return SpeedType.medium;
      case 5:
        return SpeedType.low;
      case 6:
        return SpeedType.hight;
      default:
        return SpeedType.low;
    }
  }

  double get odometerLimitSpeed {
    switch (this) {
      case SpeedType.low:
        return 160;
      case SpeedType.hight:
        return 480;
      case SpeedType.medium:
        return 2400;
    }
  }
}
