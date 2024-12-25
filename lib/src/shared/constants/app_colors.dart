import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const color7 = Color(0xFFFF8939);
  static const textApp = Color(0xFF1B1B1B);

  static const langButton = Color(0xFFF7F7F7);
  static const gray1 = Color(0xFF333333);
  static const gray2 = Color(0xFFA5A7A4);
  static const gray3 = Color(0xFF828282);
  static const whiteF5 = Color(0xFFF5F5F5);
  static const purpleFF89 = Color(0xFFFF8939);
  static const gray4 = Color(0xFFBDBDBD);
  static const tabColor = Color(0xFF82E4FF);
  static const textMap = Color(0xFF5FEFFF);
  static const redOmeter = Color(0xFFFF3A3A);
  static const textRed = Color(0xFFFF5741);
  static const yellowOmeter = Color(0xFFFF9A34);
  static const blueOmeter = Color(0xFF44D2E5);
  static const textPurple1 = Color(0xFFB53DFF);
  static const  textPink = Color(0xFFFFE0FF);
  static const  textPurple2 = Color(0xFFC3B1FF);
  static const  textPurple32 = Color(0xFF9F9FEF);
  static const color34 = Color(0xff343434);
  static const color6C6C6C = Color(0xff6c6c6c);

  static const bg = Color(0xFF181818);

  static Shader linearGradient = const LinearGradient(
    colors: [
      Color(0xff79E3BD),
      Color(0xff48c6d7),
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  static const buttonGradient = LinearGradient(
    colors: [
      Color(0xff79E3BD),
      Color(0xff4878D7),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const theme1 = LinearGradient(
    colors: [
      Color(0xff6A0D40),
      Color(0xff29001D),
      Color(0xff220018),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const borderRedGradient = LinearGradient(
    colors: [
      Color(0xff944238),
      Color(0xffC00B0A),
      Color(0xff944238),
    ],
  );
  static const borderGradient = LinearGradient(
    colors: [
      Color(0xff79E3BD),
      Color(0xff4878D7),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient dividerRedGradient = LinearGradient(
    colors: [
      const Color(0xffFF381E).withOpacity(0),
      const Color(0xffFF8E80),
      const Color(0xffFF381E).withOpacity(0),
    ],
  );
  static LinearGradient dividerGradient = LinearGradient(
    colors: [
      const Color(0xff73D4C1).withOpacity(0),
      const Color(0xff5089D3),
      const Color(0xff73D4C1).withOpacity(0),
    ],
  );
  static LinearGradient dividerHubGradient = LinearGradient(
    colors: [
      const Color(0xff73D4C1).withOpacity(0),
      const Color(0xff5089D3),
      const Color(0xff73D4C1).withOpacity(0),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static LinearGradient dividerHubRedGradient = LinearGradient(
    colors: [
      const Color(0xffFF381E).withOpacity(0),
      const Color(0xffFF8E80),
      const Color(0xffFF381E).withOpacity(0),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static var languageGradient = LinearGradient(
    colors: [
      const Color(0xA5101010).withOpacity(0.6),
      const Color(0xFF000000).withOpacity(0.6),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static var backgroundCard = LinearGradient(
    colors: [
      const Color(0xA5232323).withOpacity(0.6),
      const Color(0xFF111111).withOpacity(0.6),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const dialogGradient = LinearGradient(
    colors: [
      Color(0xff2D2D2D),
      Color(0xff0C100C),
      // Colors.black
    ],
    stops: [0, 1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const textFieldGradient = LinearGradient(
    colors: [
      Color(0xff2D2D2D),
      Color(0xff0C100C),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
  );
  static const buttonHotGradient = LinearGradient(
    colors: [
      Color(0xffFF8E80),
      Color(0xffFF381E),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient divider2Gradient = LinearGradient(
    colors: [
      const Color(0xffFFFFFF).withOpacity(0),
      const Color(0xff939393),
      const Color(0xffFFFFFF).withOpacity(0),
    ],
  );
  static LinearGradient divider3Gradient = LinearGradient(colors: [
    Colors.white.withOpacity(0),
    Colors.white.withOpacity(0.2),
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);
  static LinearGradient divider4Gradient = LinearGradient(
    colors: [
      Colors.white.withOpacity(0.2),
      Colors.white.withOpacity(0.2),
    ],
  );
  static LinearGradient premiumBgGradient = LinearGradient(
    colors: [
      const Color(0xff000000).withOpacity(0.35),
      const Color(0xff000000),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static LinearGradient premiumBgItemGradient = LinearGradient(
    colors: [
      const Color(0xff79E3BD).withOpacity(0.35),
      const Color(0xff4878D7).withOpacity(0.35),
    ],
  );
  static LinearGradient whileBorderGradient = LinearGradient(
    colors: [
      Colors.white.withOpacity(0.2),
      Colors.white.withOpacity(0.2),
    ],
  );

  static LinearGradient weatherItemGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffFFFFFF),
      const Color(0xffFFFFFF).withOpacity(0),
    ],
  );
}
