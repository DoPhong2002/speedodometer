import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/language_cubit.dart';
import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../../data/local/shared_preferences_manager.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/cubit/value_cubit.dart';
import '../../../shared/enum/language.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/number_extension.dart';
import '../../../shared/screen/cubit/bottom_tab_cubit.dart';
import '../../../shared/widgets/custom_appbar.dart';
import '../../../utils/style_utils.dart';
import '../../../widgets/gps_background.dart';
import '../../../widgets/gradient_border_widget.dart';

@RoutePage()
class LanguageScreen extends StatefulWidget implements AutoRouteWrapper {
  const LanguageScreen({
    super.key,
    this.isFirst = false,
  });

  final bool isFirst;

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    final Language currentLanguage = getIt<LanguageCubit>().state;
    return BlocProvider(
      create: (context) => ValueCubit<Language>(currentLanguage),
      child: this,
    );
  }
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return GpsBackground(
      child: OrientationBuilder(builder: (context, orientation) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: GpsAppbar(
            context,
            context.l10n.language,
            leadingWid: (widget.isFirst == false) ? kToolbarHeight : 0,
            leadingApp: (widget.isFirst == false) ? null : const SizedBox(),
            action: [_buildAcceptButton()],
            heightAppBar: orientation == Orientation.landscape ? 40 : 80,
          ),
          body: const _BodyWidget(),
        );
      }),
    );
  }

  Widget _buildAcceptButton() {
    final Language selectedLanguage =
        context.read<ValueCubit<Language>>().state;

    return BlocBuilder<ValueCubit<Language>, Language>(
      builder: (context, state) {
        return IconButton(
          onPressed: () async {
            PreferenceManager.increasePermissionCount();
            if (widget.isFirst == false) {
              getIt<LanguageCubit>().update(state);
              context.read<LanguageCubit>().update(state);
              await context.maybePop(true);
              context.read<BottomTabCubit>().changeTab(0);
              return;
            } else {
              if (mounted) {
                getIt<LanguageCubit>().update(state);
                context.read<LanguageCubit>().update(state);
                context.replaceRoute(const OnBoardingRoute());
              }
            }
          },
          icon: Icon(
            Icons.check,
            // ignore: unnecessary_null_comparison
            color: selectedLanguage == null ? Colors.grey : Colors.white,
          ),
        );
      },
    );
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget();

  @override
  State<_BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<_BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: BlocBuilder<ValueCubit<Language>, Language>(
            builder: (context, state) {
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 24),
                itemCount: Language.values.length,
                itemBuilder: (BuildContext context1, int index) {
                  final Language item = Language.values[index];
                  return _buildItemLanguage(
                    context: context,
                    language: item,
                    selectedValue: state,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget _buildItemLanguage({
  required BuildContext context,
  required Language language,
  required Language selectedValue,
}) {
  final selectedLanguageCubit = context.read<ValueCubit<Language>>();
  return GestureDetector(
    onTap: () => selectedLanguageCubit.update(language),
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 4,
      ),
      child: GradientBorder(
        gradient: selectedValue == language
            ? AppColors.borderGradient
            : LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.1),
                ],
              ),
        borderRadius: 20,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset(
                language.flagPath,
                width: 32,
                height: 32,
              ),
              16.hSpace,
              Expanded(
                child: Text(
                  language.languageName,
                  style: StyleUtils.style.bold.s16.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
