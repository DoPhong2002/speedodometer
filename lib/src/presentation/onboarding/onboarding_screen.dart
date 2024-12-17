import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../gen/gens.dart';
import '../../shared/cubit/value_cubit.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../widgets/gps_background.dart';
import 'widgets/indicator.dart';
import 'widgets/page_widget.dart';

part 'widgets/page_action.dart';

@RoutePage()
class OnBoardingScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const OnBoardingScreen({
    super.key,
  });

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => ValueCubit<int>(0),
      child: this,
    );
  }
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return GpsBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<ValueCubit<int>, int>(
          builder: (context, currentIndex) {
            return PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                context.read<ValueCubit<int>>().update(page);
              },
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                ContentPageWidget(
                  key: const ValueKey(0),
                  image: Assets.images.onboarding.onboarding1,
                  title: context.l10n.title_onboarding1,
                  description: context.l10n.description_onboarding1,
                  pageController: _pageController,
                ),
                ContentPageWidget(
                  key: const ValueKey(1),
                  image: Assets.images.onboarding.onboarding2,
                  title: context.l10n.title_onboarding2,
                  description: context.l10n.description_onboarding2,
                  pageController: _pageController,
                ),
                ContentPageWidget(
                  key: const ValueKey(2),
                  image: Assets.images.onboarding.onboarding3,
                  title: context.l10n.title_onboarding3,
                  description: context.l10n.description_onboarding3,
                  pageController: _pageController,
                ),
                ContentPageWidget(
                  key: const ValueKey(3),
                  image: Assets.images.onboarding.onboarding4,
                  title: context.l10n.title_onboarding4,
                  description: context.l10n.description_onboarding4,
                  pageController: _pageController,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
