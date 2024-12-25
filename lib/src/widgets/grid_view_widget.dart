import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../presentation/speed_limit/bloc/speed_limit_bloc.dart';
import '../shared/constants/app_colors.dart';
import '../utils/style_utils.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({super.key, required this.onTap, required this.items, required this.selectedIndex});

  final Function(int, ItemSpeed) onTap;
  final List<ItemSpeed> items;
  final ValueNotifier<int?> selectedIndex;

  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.h),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.7,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 8.h),
        itemBuilder: (context, index) {
          return ValueListenableBuilder<int?>(
            valueListenable: widget.selectedIndex,
            builder: (context, selected, child) {
              return GestureDetector(
                onTap: () {
                  widget.selectedIndex.value = index;
                  widget.onTap(index, widget.items[index]);
                },
                child: ItemGridView(
                  title: widget.items[index].title,
                  iconPath: widget.items[index].path,
                  isSelected: selected == index,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ItemGridView extends StatelessWidget {
  const ItemGridView(
      {super.key,
      required this.title,
      required this.iconPath,
      required this.isSelected});

  final String title;
  final String iconPath;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(1.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: isSelected
                ? AppColors.borderGradient
                : LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                gradient: AppColors.dialogGradient,
                borderRadius: BorderRadius.circular(15),
              ),
              child: SvgPicture.asset(
                iconPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            title,
            style: StyleUtils.style.white.regular.s12,
          ),
        )
      ],
    );
  }
}
