part of '../permission_screen.dart';

class PermissionBody extends StatefulWidget {
  const PermissionBody({super.key});

  @override
  State<PermissionBody> createState() => _PermissionContentState();
}

class _PermissionContentState extends State<PermissionBody>
    with WidgetsBindingObserver {
  final ValueNotifier<bool> notificationSwitchValue =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> locationSwitchValue = ValueNotifier<bool>(false);
  bool isRequesting = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
    super.initState();
  }

  Future<void> _checkPermission() async {
    final PermissionStatus locationStatus =
        await Permission.locationWhenInUse.status;
/*    final PermissionStatus notificationStatus =
        await Permission.notification.status;*/
    if (mounted) {
/*      context
          .read<NotificationPermissionCubit>()
          .update(notificationStatus.isGranted || notificationStatus.isLimited);*/
      context
          .read<LocationPermissionCubit>()
          .update(locationStatus.isGranted || locationStatus.isLimited);
    }
  }

  FutureOr<void> _onLocationSwitchChanged(bool value) async {
    if (isRequesting) {
      return;
    }
    if (value) {
      isRequesting = true;
      final PermissionStatus locationStatus =
          await Permission.locationWhenInUse.request();

      if (locationStatus.isGranted && mounted) {
        context
            .read<LocationPermissionCubit>()
            .update(locationStatus.isGranted);
      }else if (locationStatus.isPermanentlyDenied && mounted) {
        await showDialog(
          context: context,
          builder: (context) => RequestPermissionDialog(
            context: context,
            title: context.l10n.requestLocationPermission,
            contentText: context.l10n.pleaseGrantLocationPermission,
            buttonText: context.l10n.goToSetting,
            pathImage: Assets.icons.permission.icLocationPermission.path,
            onClosed: () => context.maybePop(),
            onButtonTap: () async {
              context.maybePop();
              await openAppSettings();
            },
          ),
        );
      }
      isRequesting = false;
    }
  }

  FutureOr<void> _onNotificationSwitchChanged(bool value) async {
    if (isRequesting) {
      return;
    }
    if (value) {
      isRequesting = true;
      final PermissionStatus notificationStatus =
          await Permission.notification.request();
      if (notificationStatus.isGranted && mounted) {
        context
            .read<NotificationPermissionCubit>()
            .update(notificationStatus.isGranted);
      }
      if (notificationStatus.isPermanentlyDenied && mounted) {
        await showDialog(
          context: context,
          builder: (context) => RequestPermissionDialog(
            context: context,
            title: context.l10n.requestLocationPermission,
            contentText: context.l10n.pleaseGrantLocationPermission,
            buttonText: context.l10n.goToSetting,
            pathImage: Assets.icons.permission.icLocationPermission.path,
            onClosed: () => context.maybePop(),
            onButtonTap: () async {
              context.maybePop();
              await openAppSettings();
            },
          ),
        );
      }
      isRequesting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Assets.images.logo.logoPermission.image(height: 215, width: 175),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Text(
                context.l10n.gps,
                textAlign: TextAlign.center,
                style: StyleUtils.style.white.regular.s16,
              ),
            ),
       /*     _buildItem(
              title: context.l10n.notification,
              cubit: context.read<NotificationPermissionCubit>(),
              onChanged: _onNotificationSwitchChanged,
            ),*/
            _buildItem(
              title: context.l10n.location,
              cubit: context.read<LocationPermissionCubit>(),
              onChanged: _onLocationSwitchChanged,
            ),
            24.verticalSpace,
            Builder(builder: (context) {
              final locationStatus =
                  context.watch<LocationPermissionCubit>().state;
              final notificationStatus =
                  context.watch<NotificationPermissionCubit>().state;
              return ButtonWidget(
                onTap: () async {
                  if (context.mounted) {
                    PreferenceManager.saveIsFirstPermission(false);
                    context.replaceRoute(const ShellRoute());
      /*              PreferenceManager.saveIsFirstPermission(false);
                    final int count =
                        await PreferenceManager.getCountPermission();
                    if (count == 1 && context.mounted) {
                      context.pushRoute(
                          PremiumFirstRoute(nextPage: const ShellRoute()));
                    } else if (count == 2 && context.mounted) {
                      context.pushRoute(
                          PremiumSecondRoute(nextPage: const ShellRoute()));
                    } else if (count >= 3 && context.mounted) {
                      context.pushRoute(
                          PremiumThirdRoute(nextPage: const ShellRoute()));
                    }*/
                  }
                },
                child: Text(
                  notificationStatus || locationStatus
                      ? context.l10n.continueText
                      : context.l10n.continueWithPermission,
                  style: StyleUtils.style.white.s16,
                ),
              );
            }),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }

  Container _buildItem({
    required String title,
    required ValueCubit<bool> cubit,
    required FutureOr<void> Function(bool value) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 8.h),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          gradient: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: StyleUtils.style.regular.s16.white),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: BlocBuilder<ValueCubit<bool>, bool>(
                bloc: cubit,
                builder: (context, state) => PermissionSwitch(
                  value: state,
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _checkPermission();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
