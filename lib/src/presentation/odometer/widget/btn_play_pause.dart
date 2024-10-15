import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../gen/assets.gen.dart';
import '../../../shared/constants/app_colors.dart';
import '../../setting/bloc/setting_bloc.dart';

class BtnPlayStartOrPause extends StatefulWidget {
  const BtnPlayStartOrPause({
    super.key,
    required this.callbackPlay,
    required this.callbackStop,
    required this.pause,
  });

  final VoidCallback callbackPlay;
  final VoidCallback callbackStop;
  final bool pause;

  @override
  State<BtnPlayStartOrPause> createState() => _BtnPlayStartOrPauseState();
}

class _BtnPlayStartOrPauseState extends State<BtnPlayStartOrPause> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SizedBox(
          height: 2,
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.dividerRedGradient,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(1),
          decoration: const BoxDecoration(
            gradient: AppColors.borderRedGradient,
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          child: Container(
            height: 41,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage(Assets.images.map.btnBg.path),
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.8), BlendMode.dstATop),
                    fit: BoxFit.fill)),
            child: IntrinsicHeight(
              child: BlocBuilder<SettingBloc, SettingState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            widget.callbackPlay();
                          },
                          icon: SvgPicture.asset(!widget.pause
                              ? Assets.icons.map.icStart.path
                              : Assets.icons.map.icResume.path)),
                      VerticalDivider(
                        indent: 4,
                        endIndent: 4,
                        width: 2,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      IconButton(
                          onPressed: () {
                            widget.callbackStop();
                          },
                          icon:
                              SvgPicture.asset(Assets.icons.map.icPause.path)),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
