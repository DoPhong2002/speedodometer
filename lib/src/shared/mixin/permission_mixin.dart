import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../gen/assets.gen.dart';
import '../extension/context_extension.dart';
import '../widgets/request_permission_dialog.dart';

mixin PermissionMixin<T extends StatefulWidget> on State<T> {
  Future<bool> checkPermissionLocation() async {
    final PermissionStatus locationStatus =
        await Permission.locationWhenInUse.status;
    return locationStatus.isGranted;
  }

  Future<PermissionStatus> checkPermissionLocationStatus() async {
    final PermissionStatus locationStatus =
    await Permission.locationWhenInUse.status;
    return locationStatus;
  }

  Future<bool> requestPermissionLocation() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  Future<PermissionStatus> requestPermissionLocationAlways() async {
    final PermissionStatus location = await Permission.locationAlways.status;
    return location;
  }

  Future<bool> checkPermissionCamera() async {
    final PermissionStatus cameraStatus = await Permission.camera.status;
    return cameraStatus.isGranted;
  }

  Future<bool> requestPermissionCamera() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> checkPermissionGallery() async {
    final PermissionStatus galleryStatus = await Permission.photos.status;
    bool requestSuccess = galleryStatus.isGranted;
    if (!requestSuccess) {
      requestSuccess = await requestPermissionGallery();
    }
    return requestSuccess;
  }

  Future<bool> requestPermissionGallery() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  Future<bool> checkPermissionNotify() async {
    final PermissionStatus notifyStatus = await Permission.notification.status;
    return notifyStatus.isGranted;
  }

  Future<bool> requestPermissionNotify() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<dynamic> showDialogGoToSetting(
      {required String title,
      required String content,
      required String image,
      bool location = false,
      VoidCallback? callback,
      VoidCallback? onTap,}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => GestureDetector(
        onTap: (){
          context.maybePop();
          callback!();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: RequestPermissionDialog(
            context: context,
            title: title,
            contentText: content,
            buttonText: context.l10n.goToSetting,
            pathImage: image,
            onButtonTap: () async {
              context.maybePop();
              onTap?.call();
              await openAppSettings();
            },
            onClosed: () {
              context.maybePop();
              callback!();
            },
            heightBtn: 40,
          ),
        ),
      ),
    );
  }

  Future<PermissionStatus> requestNotificationPermissionDialog() async {
    PermissionStatus status = PermissionStatus.denied;
    bool isPermanentlyDenied = false;
    isPermanentlyDenied = await Permission.notification.isPermanentlyDenied;
    if (isPermanentlyDenied) {
      await showDialogGoToSetting(
          title: context.l10n.requestNotification,
          content: context.l10n.subTitleRequestNotify,
          image: Assets.icons.permission.icNotificationPermission.path);
    } else {
      status = await Permission.notification.request();
      if (!status.isGranted) {
        showDialogGoToSetting(
            title: context.l10n.requestNotification,
            content: context.l10n.subTitleRequestNotify,
            image: Assets.icons.permission.icCameraPermission.path);
      }
    }
    return status;
  }
}
