import 'dart:math' as math;
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/mixin/permission_mixin.dart';
import '../../../shared/widgets/custom_appbar.dart';
import '../../../utils/direction_utils.dart';
import '../../../utils/style_utils.dart';
import '../../../widgets/dialog/dialog_widget.dart';
import '../../../widgets/gps_background.dart';
import 'cubit/compass_cubit.dart';

@RoutePage()
class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen>
    with PermissionMixin, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkCompassAvailability();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
  }

  Future<bool> _checkCompassAvailability() async {
    try {
      final compassEvent = await FlutterCompass.events?.first;
      if (compassEvent?.heading != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GpsBackground(
      child: OrientationBuilder(builder: (context, orientation) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: GpsAppbar(
            context,
            context.l10n.compass,
            heightAppBar: orientation == Orientation.landscape ? 40 : 80,
          ),
          body: FutureBuilder<bool>(
            future: _checkCompassAvailability(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || !snapshot.hasData || !snapshot.data!) {
                return _dialogNotSupportCompass();
              }
              return _buildCompass();
            },
          ),
        );
      }),
    );
  }

  Widget _buildCompass() {
    return BlocBuilder<CompassCubit, CompassState>(
      builder: (context, state) {
        if (state.hasError) {
          return Center(
            child: Text(
              'Error reading heading',
              style: StyleUtils.style.white.s72,
            ),
          );
        }

        if (state.direction == null) {
          return const Center(child: CircularProgressIndicator());
        }

        double direction = (state.direction ?? 0 + 360) % 360;
        final orientation = MediaQuery.of(context).orientation;
        final size = orientation == Orientation.portrait ? 1.sw : 1.sh;
        return Stack(
          alignment: Alignment.center,
          children: [
            Assets.images.ellipseCompass.image(
                fit: BoxFit.cover, height: 1.35 * size, width: 1.15 * size),
            // Rotating Image
            Transform.rotate(
              angle: direction * (math.pi / 180) * -1,
              child: Image.asset(
                Assets.images.compass.path,
                fit: BoxFit.fitWidth,
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 0.5,
              child: Image.asset(
                Assets.images.compassControl.path,
              ),
            ),
            // Rotating Text
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${direction.toInt()}°',
                    style: StyleUtils.style.white.s45.bold,
                  ),
                  Text(
                    direction.getDirection,
                    style: StyleUtils.style.white.s16.bold,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _dialogNotSupportCompass() {
    return DialogWidget(
      contentWidget: Column(
        children: [
          SvgPicture.asset(
            Assets.icons.trip.icError.path,
            height: 120.h,
            width: 120.w,
            color: Colors.red,
          ),
          Text(
            'Compass not found',
            style: StyleUtils.style.white.s16,
          ),
        ],
      ),
      onConfirm: () => context.maybePop(),
      oneButton: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
