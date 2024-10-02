import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../gen/fonts.gen.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../utils/style_utils.dart';
import '../../setting/bloc/setting_bloc.dart';

class ItemTextFieldValidateWidget extends StatelessWidget {
  const ItemTextFieldValidateWidget({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                  gradient: AppColors.textFieldGradient,
                  borderRadius: BorderRadius.circular(16.h),
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(color: Colors.white.withOpacity(0.1))),
              child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.blue,
                  textAlign: TextAlign.center,
                  style: StyleUtils.style.regular.white
                      .copyWith(color: Colors.white.withOpacity(0.2))
                      .s16
                      .copyWith(
                          fontFamily: state.fontType == 0
                              ? FontFamily.sfpro
                              : FontFamily.dsdigi,
                          fontSize: state.fontType == 0 ? 16 : 16.5),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: context.l10n.hintEnterSpeed,
                      hintStyle: StyleUtils.style.regular.white
                          .copyWith(color: Colors.white.withOpacity(0.2))
                          .s16),
                  selectionControls: EmptyTextSelectionControls()),
            );
          },
        ),
      ],
    );
  }
}
