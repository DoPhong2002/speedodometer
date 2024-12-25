import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:odometer/src/presentation/permission/widget/permission_switch.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/cubit/value_cubit.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/mixin/permission_mixin.dart';
import '../../../utils/style_utils.dart';

Future<dynamic> showBottomSheetPermission(
    BuildContext context, Widget child) async {
  final result = await showModalBottomSheet(
    backgroundColor: Colors.black,
    clipBehavior: Clip.antiAlias,
    isScrollControlled: true,
    context: context,
    builder: (context) => child,
  );
  return result;
}

class LocationBottomScreen extends StatefulWidget {
  const LocationBottomScreen({super.key});

  @override
  State<LocationBottomScreen> createState() => _LocationBottomScreenState();
}

class _LocationBottomScreenState extends State<LocationBottomScreen>
    with PermissionMixin, WidgetsBindingObserver {
  final ValueCubit<bool> locationCubit = ValueCubit(true);

  FutureOr<void> _onLocationSwitchChanged(BuildContext context) async {
    final reject = await Permission.locationWhenInUse.isPermanentlyDenied;
    if (reject) {
      showGoToSetting();
      return;
    }
    await requestPermissionLocation();
  }

  Future<void> showGoToSetting() async {
    await showDialogGoToSetting(
        title: context.l10n.requestLocationPermission,
        content: context.l10n.pleaseGrantLocationPermission,
        image: Assets.icons.permission.icLocationPermission.path,
        callback: () {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      final statusLocation = await checkPermissionLocationStatus();
      locationCubit.update(statusLocation.isGranted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(color: Color(0xff121315)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            10.verticalSpace,
            Text(context.l10n.permission,
                style: StyleUtils.style.s20.bold.white),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    10.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        _onLocationSwitchChanged(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            gradient: AppColors.buttonGradient),
                        child: Text(
                          context.l10n.location,
                          style: StyleUtils.style.white.s16,
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        context.l10n.requestLocationPermission,
                        textAlign: TextAlign.center,
                        style: StyleUtils.style.s18.white.bold,
                      ),
                    ),
                    4.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        'Speed requires permissions to access device features ${context.l10n.location}',
                        textAlign: TextAlign.center,
                        style: StyleUtils.style.s16.white.regular,
                      ),
                    ),
                    24.verticalSpace,
                    SvgPicture.asset(
                      Assets.icons.permission.icLocationPermission.path,
                      height: 140.h,
                      width: 140.h,
                    ),
                    24.verticalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 24.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffE4ECFF),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                'You can select: ${context.l10n.location}',
                                style: StyleUtils.style.s16.regular.white),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: BlocBuilder<ValueCubit<bool>, bool>(
                              bloc: locationCubit,
                              builder: (context, state) => PermissionSwitch(
                                  value: state,
                                  onChanged: (value) {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Please click button Location to grant permission!');
                                  }),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            16.verticalSpace,
            /*const NativeAllAd(
              remoteKey: AdRemoteKeys.new_permission_inapp,
              ignoreRouteObserver: true,
            )*/
          ],
        ),
      ),
    );
  }
}
