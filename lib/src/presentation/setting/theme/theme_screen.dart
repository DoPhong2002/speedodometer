import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/di/di.dart';
import '../../../data/local/shared_preferences_manager.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/screen/cubit/bottom_tab_cubit.dart';
import '../../../shared/widgets/custom_appbar.dart';
import '../../../utils/style_utils.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/gps_background.dart';
import '../../onboarding/widgets/indicator.dart';
import 'cubit/theme_cubit.dart';

@RoutePage()
class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  final ValueNotifier<int> odometerNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    odometerNotifier.value = getIt<ThemeCubit>().state;
  }

  void popToHome() {
    getIt<BottomTabCubit>().changeTab(2);
    context.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items =
        ThemeOdometer.values.map((theme) => theme.getImage(1.sw)).toList();

    return GpsBackground(
      child: OrientationBuilder(
        builder: (context, orientation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: GpsAppbar(
              context,
              context.l10n.odometer_theme,
              heightAppBar: orientation == Orientation.landscape ? 40 : 80,
            ),
            body: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        initialPage: odometerNotifier.value,
                        aspectRatio: 1 / 2,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          odometerNotifier.value = index;
                        },
                      ),
                      items: items,
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: odometerNotifier,
                  builder: (context, value, child) {
                    return CustomIndicator(
                      length: items.length,
                      currentIndex: odometerNotifier.value,
                    );
                  },
                ),
                8.verticalSpace,
                Padding(
                  padding: EdgeInsets.all(24.h),
                  child: ButtonWidget(
                    onTap: () async {
                      getIt<ThemeCubit>().changeTheme(odometerNotifier.value);
                      await PreferenceManager.setThemeOdometer(
                          odometerNotifier.value);
                      popToHome();
                    },
                    child: Center(
                      child: Text(context.l10n.select,
                          textAlign: TextAlign.center,
                          style: StyleUtils.style.white.bold.s16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

enum ThemeOdometer {
  theme0,
  theme1,
  theme2,
  theme4,
  theme5,
  theme6;

  static ThemeOdometer fromValue(int value) {
    switch (value) {
      case 0:
        return ThemeOdometer.theme0;
      case 1:
        return ThemeOdometer.theme1;
      case 2:
        return ThemeOdometer.theme2;
      case 3:
        return ThemeOdometer.theme4;
      case 4:
        return ThemeOdometer.theme5;
      case 5:
        return ThemeOdometer.theme6;
      default:
        return ThemeOdometer.theme0;
    }
  }

  Widget getImage(double width) {
    switch (this) {
      case ThemeOdometer.theme0:
        return Assets.images.odometer.theme0.theme0.image(width: width);
      case ThemeOdometer.theme1:
        return Assets.images.odometer.theme1.theme1.image(width: width);
      case ThemeOdometer.theme2:
        return Assets.images.odometer.theme2.theme2.image(width: width);
      case ThemeOdometer.theme4:
        return Assets.images.odometer.theme4.theme4.image(width: width);
      case ThemeOdometer.theme5:
        return Assets.images.odometer.theme5.theme5.image(width: width);
      case ThemeOdometer.theme6:
        return Assets.images.odometer.theme6.theme6.image(width: width);
    }
  }
}
