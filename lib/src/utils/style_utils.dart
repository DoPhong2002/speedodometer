import 'package:flutter/material.dart';

import '../gen/fonts.gen.dart';
import '../shared/constants/app_colors.dart';

mixin StyleUtils {
  static TextStyle get style => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.sfpro,
      );
}

extension TypographiesColor on TextStyle {
  TextStyle get white => copyWith(color: Colors.white);

  TextStyle get black => copyWith(color: Colors.black);

  TextStyle get textApp => copyWith(color: AppColors.textApp);

  TextStyle get color7 => copyWith(color: AppColors.color7);

  TextStyle get gray1 => copyWith(color: AppColors.gray1);

  TextStyle get gray3 => copyWith(color: AppColors.gray3);

  TextStyle get purpleFF89 => copyWith(color: AppColors.purpleFF89);

  TextStyle get gray4 => copyWith(color: AppColors.gray4);

  TextStyle get gray2 => copyWith(color: AppColors.gray2);

  TextStyle get textMap => copyWith(color: AppColors.textMap);

  TextStyle get textBlue => copyWith(color: AppColors.tabColor);

  TextStyle get textRed => copyWith(color: AppColors.textRed);

  TextStyle get textPurple1 => copyWith(color: AppColors.textPurple1);

  TextStyle get textPurple2 => copyWith(color: AppColors.textPurple2);

  TextStyle get textPink => copyWith(color: AppColors.textPink);

  TextStyle get textPurple32 => copyWith(color: AppColors.textPurple32);

  TextStyle get color34 => copyWith(color: AppColors.color34);
  TextStyle get color6C6C6C => copyWith(color: AppColors.color6C6C6C);

}

extension TypographiesWeight on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);
}

extension TypographiesSize on TextStyle {
  TextStyle get s10 => copyWith(fontSize: 10);

  TextStyle get s12 => copyWith(fontSize: 12);

  TextStyle get s14 => copyWith(fontSize: 14);

  TextStyle get s15 => copyWith(fontSize: 15);

  TextStyle get s16 => copyWith(fontSize: 16);

  TextStyle get s17 => copyWith(fontSize: 17);

  TextStyle get s18 => copyWith(fontSize: 18);

  TextStyle get s20 => copyWith(fontSize: 20);

  TextStyle get s21 => copyWith(fontSize: 21);

  TextStyle get s22 => copyWith(fontSize: 22);

  TextStyle get s23 => copyWith(fontSize: 23);

  TextStyle get s24 => copyWith(fontSize: 24);

  TextStyle get s25 => copyWith(fontSize: 25);

  TextStyle get s28 => copyWith(fontSize: 28);

  TextStyle get s36 => copyWith(fontSize: 36);

  TextStyle get s40 => copyWith(fontSize: 40);

  TextStyle get s45 => copyWith(fontSize: 45);

  TextStyle get s51 => copyWith(fontSize: 51);

  TextStyle get s72 => copyWith(fontSize: 72);

  TextStyle get s96 => copyWith(fontSize: 96);

  TextStyle get s180 => copyWith(fontSize: 180);
}

extension TypographiesLineHeight on TextStyle {
  TextStyle get h18 => copyWith(height: 18 / fontSize!);

  TextStyle get h21 => copyWith(height: 21 / fontSize!);

  TextStyle get h24 => copyWith(height: 24 / fontSize!);

  TextStyle get h30 => copyWith(height: 30 / fontSize!);

  TextStyle get h36 => copyWith(height: 36 / fontSize!);

}
