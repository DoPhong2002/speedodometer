import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../map/cubit/speed_cubit.dart';
import '../../map/cubit/timer_cubit.dart';
import '../../map/widget/btn_play_pause_map.dart';
import '../../map/widget/btn_start_map.dart';

class ActionControl extends StatelessWidget {
  const ActionControl({
    super.key,
    this.isActivity = false,
    required this.onTap,
  });

  final Function onTap;
  final bool isActivity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitial() => [
                  BtnStartMap(callback: () async {
                    if (isActivity) {
                      context
                          .read<TimerBloc>()
                          .add(TimerStarted(duration: state.duration));
                      context.read<SpeedCubit>().startTracking();
                    } else {
                      onTap();
                    }
                  })
                ],
              TimerRunInProgress() => [
                  BtnPlayStartOrPause(
                    callbackPlay: () {
                      context.read<TimerBloc>().add(const TimerPaused());
                      context.read<SpeedCubit>().pauseTracking();
                    },
                    callbackStop: () {
                      context.read<TimerBloc>().add(const TimerReset());
                      context.read<SpeedCubit>().stopTracking();
                    },
                    pause: true,
                  ),
                ],
              TimerRunPause() => [
                  BtnPlayStartOrPause(
                    callbackPlay: () {
                      context.read<TimerBloc>().add(const TimerResumed());
                      context.read<SpeedCubit>().startTracking();
                    },
                    callbackStop: () {
                      context.read<TimerBloc>().add(const TimerReset());
                      context.read<SpeedCubit>().stopTracking();
                    },
                    pause: false,
                  ),
                ],
              TimerRunComplete() => []
            },
          ],
        );
      },
    );
  }
}
