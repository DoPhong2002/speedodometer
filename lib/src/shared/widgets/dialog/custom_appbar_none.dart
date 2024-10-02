import 'package:flutter/material.dart';

import '../../../utils/style_utils.dart';

class GpsAppbarNone extends AppBar {
  GpsAppbarNone(
      this.context,
      this.titleApp, {
        super.key,
        this.action,
        this.style,
        this.leadingApp,
        this.titleCenter = false,
        this.automaticallyLeading = false,
      });

  final BuildContext context;
  final List<Widget>? action;
  final String titleApp;
  final TextStyle? style;
  final Widget? leadingApp;
  final bool titleCenter;
  final bool automaticallyLeading;

  @override
  Widget? get title =>
      Text(titleApp, style: style ?? StyleUtils.style.s24.white.semiBold);

  @override
  bool? get centerTitle => titleCenter;

  @override
  double? get toolbarHeight => 50;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Color? get backgroundColor => Colors.transparent;

  @override
  List<Widget>? get actions => action;

  @override
  bool get automaticallyImplyLeading => automaticallyLeading;
}
