import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../utils/style_utils.dart';

class GpsAppbar extends AppBar {
  GpsAppbar(
    this.context,
    this.titleApp, {
    super.key,
    this.action,
    this.style,
    this.leadingApp,
    this.titleCenter = false,
    this.automaticallyLeading = false,
    this.leadingWid,
    this.heightAppBar,
  });

  final BuildContext context;
  final List<Widget>? action;
  final String titleApp;
  final TextStyle? style;
  final Widget? leadingApp;
  final bool titleCenter;
  final bool automaticallyLeading;
  final double? leadingWid;
  final double? heightAppBar;

  @override
  Widget? get title =>
      Text(titleApp, style: style ?? StyleUtils.style.s24.white.semiBold);

  @override
  bool? get centerTitle => titleCenter;

  @override
  double? get toolbarHeight => heightAppBar ?? 50;

  @override
  Size get preferredSize => Size.fromHeight(heightAppBar ?? 50);

  @override
  Color? get backgroundColor => Colors.transparent;

  @override
  List<Widget>? get actions => action;

  @override
  bool get automaticallyImplyLeading => automaticallyLeading;

  @override
  double? get leadingWidth => leadingWid ?? kToolbarHeight;

  @override
  Widget? get leading =>
      leadingApp ??
      IconButton(
        onPressed: () {
          context.maybePop();
        },
        icon: Assets.icons.icArrowLeft.svg(),
      );
}
