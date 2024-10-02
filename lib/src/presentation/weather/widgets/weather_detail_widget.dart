import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/style_utils.dart';

class WeatherDetailWidget extends StatelessWidget {
  const WeatherDetailWidget(
      {super.key, required this.city, required this.time, required this.range});

  final String city;
  final String time;
  final String range;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(city, style: StyleUtils.style.white.medium.s16),
          Text(time, style: StyleUtils.style.white.regular.s16),
          Text(range, style: StyleUtils.style.white.regular.s16),
        ],
      ),
    );
  }
}
