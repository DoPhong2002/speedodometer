part of '../shell_screen.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({
    super.key,
    required this.activeIndex,
    required this.onTabChange,
  });

  final int activeIndex;
  final void Function(int index) onTabChange;

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar>
    with PermissionMixin {
  bool select = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                Assets.images.bottomBar.path,
              ),
              fit: BoxFit.fill)),
      child: Row(
        children: [
          Expanded(
            child: buildItem(
              icon: Assets.icons.tabbar.icHub,
              label: context.l10n.hud,
              isActive: widget.activeIndex == 0,
              onTap: () => widget.onTabChange(0),
            ),
          ),
          10.horizontalSpace,
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                fabNavigationBar(
                  isActive: widget.activeIndex == 1,
                  onTap: () => widget.onTabChange(1),
                ),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                       color: widget.activeIndex == 1
                          ? AppColors.tabColor
                          : Colors.transparent,
                      blurRadius: 20,
                    )
                  ]),
                )
              ],
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: buildItem(
              icon: Assets.icons.tabbar.icSetting,
              label: context.l10n.setting,
              isActive: widget.activeIndex == 2,
              onTap: () => widget.onTabChange(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget fabNavigationBar({
    bool isActive = false,
    void Function()? onTap,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0), // Độ cong của bo tròn
          ),
          onPressed: onTap,
          child: Container(
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(-2, 2),
                  blurRadius: 8,
                  color: Colors.white.withOpacity(0.3),
                ),
              ],
            ),
            child: Assets.icons.tabbar.icOdometer
                .svg(height: 24, fit: BoxFit.scaleDown),
          ),
        ),
        12.verticalSpace,
        InkWell(
          onTap: onTap,
          child: Text(
            context.l10n.odometer,
            style: TextStyle(
              fontSize: 12,
              color: !isActive ? Colors.white : AppColors.tabColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildItem({
    required SvgGenImage icon,
    required String label,
    bool isActive = false,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap!();
        setState(() {
          select = false;
        });
      },
      child: Column(
        children: [
          40.verticalSpace,
          icon.svg(
            height: 24,
            colorFilter: ColorFilter.mode(
              !isActive || select ? Colors.white : AppColors.tabColor,
              BlendMode.srcIn,
            ),
          ),
          12.verticalSpace,
          FittedBox(
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color:
                      !isActive || select ? Colors.white : AppColors.tabColor,
                  height: 1,
                ),
              ),
            ),
          ),
          4.verticalSpace,
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: isActive ? AppColors.tabColor : Colors.transparent,
                blurRadius: 20,
              )
            ]),
          )
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 30.r),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: isActive ? AppColors.tabColor : Colors.transparent,
          //   ),
          //   child: Divider(
          //     color: isActive ? AppColors.tabColor : Colors.transparent,
          //     height: 3,
          //     indent: 30,
          //     endIndent: 30,
          //     thickness: 2,
          //   ),
          // )
        ],
      ),
    );
  }
}
