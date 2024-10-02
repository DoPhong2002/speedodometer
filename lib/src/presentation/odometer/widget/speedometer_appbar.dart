
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../gen/assets.gen.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../utils/style_utils.dart';

class SpeedometerAppbar extends AppBar {
  SpeedometerAppbar(
    this.context, {
    super.key,
    this.onActionTapped,
  });

  final BuildContext context;
  final VoidCallback? onActionTapped;

  @override
  Widget? get title => Text(context.l10n.speedometer,
      style: StyleUtils.style.s24.white.semiBold);

  @override
  bool? get centerTitle => true;

  @override
  double? get toolbarHeight => 30;

  @override
  Size get preferredSize => const Size.fromHeight(30);

  @override
  Color? get backgroundColor => Colors.transparent;

  @override
  bool get automaticallyImplyLeading => false;

/*@override
  Widget? get leading => IconButton(onPressed: onActionTapped, icon: SvgPicture.asset(Assets.icons.flightMode.path));*/
}
