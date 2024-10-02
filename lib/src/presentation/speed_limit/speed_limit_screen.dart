import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/widgets/custom_appbar.dart';
import '../../widgets/dialog/dialog_widget.dart';
import '../../widgets/gps_background.dart';
import 'bloc/speed_limit_bloc.dart';
import 'bloc/speed_limit_event.dart';
import 'bloc/speed_limit_state.dart';
import 'widgets/item_speed_limit_widget.dart';
import 'widgets/item_textfield_validate_widget.dart';

@RoutePage()
class SpeedLimitScreen extends StatefulWidget {
  const SpeedLimitScreen({super.key});

  @override
  State<SpeedLimitScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SpeedLimitScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SpeedLimitBloc>().add(SpeedInitEvent());
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GpsBackground(
      child: OrientationBuilder(
        builder: (context, orientation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: GpsAppbar(
              context,
              context.l10n.setSpeedLimit,
              heightAppBar: orientation == Orientation.landscape ? 40 : 80,
            ),
            body: BlocBuilder<SpeedLimitBloc, SpeedLimitState>(
              builder: (context, state) {
                final speedLimitList = state.allSpeedLimits.entries.toList();
                return ListView.builder(
                  itemCount: speedLimitList.length,
                  padding: const EdgeInsets.all(24),
                  itemBuilder: (context, index) {
                    final entry = speedLimitList[index];
                    final vehicleType = entry.key;
                    final item = entry.value;
                    return ItemSpeedLimitWidget(
                      itemSpeed: item,
                      onTapItem: () {
                        controller.text = item.speed.toString();
                        DialogWidget.showDialogWidget(
                          context: context,
                          title: context.l10n.vehicle,
                          contentWidget: Column(
                            children: [
                              ItemTextFieldValidateWidget(
                                  controller: controller)
                            ],
                          ),
                          onConfirm: () {
                            context
                                .read<SpeedLimitBloc>()
                                .add(SpeedInputEvent(
                                  vehicleType: vehicleType,
                                  inputSpeed: controller.text,
                              index: index
                                ));
                            context.maybePop();
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
