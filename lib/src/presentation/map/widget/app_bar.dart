import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../gen/fonts.gen.dart';
import '../../../utils/style_utils.dart';
import '../../../utils/text_utils.dart';
import '../../../utils/time_utlil.dart';
import '../../../utils/unit_utils.dart';
import '../../setting/bloc/setting_bloc.dart';
import '../cubit/timer_cubit.dart';

class MapAppBar extends StatefulWidget {
  const MapAppBar({
    super.key,
    this.length = 0,
  });

  final double length;

  @override
  State<MapAppBar> createState() => _MapAppBarState();
}

class _MapAppBarState extends State<MapAppBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.fromLTRB(
        ScreenUtil().statusBarHeight,
        ScreenUtil().statusBarHeight,
        ScreenUtil().statusBarHeight,
        0,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SettingBloc, SettingState>(
              builder: (context, state) {
                return TextUtils.cardAppBarMap(
                  context,
                  '${(widget.length / 1000).convertUnit(state.distanceUnit) == 0.0 ? 0 : (widget.length / 1000).convertUnit(state.distanceUnit)}',
                  unit: state.distanceUnit,
                  style: StyleUtils.style.white.bold.s16.copyWith(
                      fontFamily: state.fontType == 0
                          ? FontFamily.sfpro
                          : FontFamily.dsdigi,
                      fontSize: state.fontType == 0 ? 16 : 20),
                );
              },
            ),
            12.verticalSpace,
            BlocBuilder<TimerBloc, TimerState>(
              builder: (context, state) {
                return BlocBuilder<SettingBloc, SettingState>(
                  builder: (context, stateSetting) {
                    return TextUtils.cardAppBarMap(
                      context,
                      state.toString().convertToHMMSS(),
                      style: StyleUtils.style.white.bold.s16.copyWith(
                          fontFamily: stateSetting.fontType == 0
                              ? FontFamily.sfpro
                              : FontFamily.dsdigi,
                          fontSize: stateSetting.fontType == 0 ? 16 : 20),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
