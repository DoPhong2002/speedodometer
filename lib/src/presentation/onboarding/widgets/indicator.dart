import 'package:flutter/material.dart';

import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';

class CustomIndicator extends StatefulWidget {
  const CustomIndicator({
    super.key,
    required this.length,
    required this.currentIndex,
  });

  final int length;
  final int currentIndex;

  @override
  State<CustomIndicator> createState() => _CustomIndicatorState();
}

class _CustomIndicatorState extends State<CustomIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: ListView.separated(
        itemBuilder: (context, index) =>
            indicator(context, index == widget.currentIndex),
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: widget.length,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
      ),
    );
  }

  Widget indicator(BuildContext context, bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive
            ? context.colorScheme.primary
            : context.colorScheme.primary.withOpacity(0.4),
        gradient: AppColors.borderGradient,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
