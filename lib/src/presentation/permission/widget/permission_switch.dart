import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/constants/app_colors.dart';

class PermissionSwitch extends StatefulWidget {
  const PermissionSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.small = false
  });

  final bool value;
  final void Function(bool value) onChanged;
  final bool small;

  @override
  State<PermissionSwitch> createState() => _PermissionSwitchState();
}

class _PermissionSwitchState extends State<PermissionSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(
              color: const Color(0xff808080).withOpacity(0.2),
              borderRadius: BorderRadius.circular(100).r,
            ),
            width: 48.r,
            height: 24.r,
          ),
          AnimatedPositioned(
            top: 2.r,
            left: widget.value ? 26.r : 2.r,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: Container(
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30).r,
                color: Colors.white,
                gradient: widget.value ? AppColors.borderGradient : null,
              ),
            ),
          )
        ],
      ),
    );
  }
}
