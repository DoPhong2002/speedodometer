import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../config/navigation/app_router.dart';
import '../../data/local/shared_preferences_manager.dart';
import '../../gen/assets.gen.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/cubit/value_cubit.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/widgets/custom_appbar.dart';
import '../../shared/widgets/request_permission_dialog.dart';
import '../../utils/style_utils.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/dialog/dialog_widget.dart';
import '../../widgets/gps_background.dart';
import 'cubit/location_status_cubit.dart';
import 'cubit/notification_status_cubit.dart';
import 'widget/permission_switch.dart';

part 'widget/permission_body.dart';

@RoutePage()
class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotificationPermissionCubit(false),
        ),
        BlocProvider(
          create: (context) => LocationPermissionCubit(false),
        ),
      ],
      child: GpsBackground(
        child: OrientationBuilder(builder: (context, orientation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: GpsAppbar(
              context,
              context.l10n.permission,
              leadingWid: 0,
              heightAppBar: orientation == Orientation.landscape ? 40 : 80,
            ),
            body: const PermissionBody(),
          );
        }),
      ),
    );
  }
}
