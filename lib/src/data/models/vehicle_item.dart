import '../../gen/assets.gen.dart';
import '../../utils/localization_util.dart';

class IconModel {
  IconModel({required this.iconPath, required this.title});

  String iconPath;
  String title;
}

enum VehicleItem {
  walking,
  bicycle,
  motorcycle,
  car,
  train,
  boat,
  air,
}

extension VehicleItemExt on VehicleItem {
  String get name {
    return switch (this) {
      VehicleItem.walking => L10n.tr.walking,
      VehicleItem.bicycle => L10n.tr.bicycle,
      VehicleItem.motorcycle => L10n.tr.motorcycle,
      VehicleItem.car => L10n.tr.car,
      VehicleItem.train => L10n.tr.train,
      VehicleItem.boat => L10n.tr.boat,
      VehicleItem.air => L10n.tr.air_plane,
    };
  }

  String get pathImage {
    return switch (this) {
      VehicleItem.walking => Assets.icons.dialog.walking.path,
      VehicleItem.bicycle => Assets.icons.dialog.bicycle.path,
      VehicleItem.motorcycle => Assets.icons.dialog.motorcycle.path,
      VehicleItem.car => Assets.icons.dialog.car.path,
      VehicleItem.train => Assets.icons.dialog.train.path,
      VehicleItem.boat => Assets.icons.dialog.boat.path,
      VehicleItem.air => Assets.icons.dialog.air.path,
    };
  }
}

extension VehicleList on VehicleItem {
  List<IconModel> get data {
    List<IconModel> dataList = [];
    dataList = VehicleItem.values
        .map((item) => IconModel(
              title: item.name,
              iconPath: item.pathImage,
            ))
        .toList();
    return dataList;
  }
}
