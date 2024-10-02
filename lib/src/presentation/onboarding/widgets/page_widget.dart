import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/navigation/app_router.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/cubit/value_cubit.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/number_extension.dart';
import '../../../utils/style_utils.dart';
import '../../../widgets/button_widget.dart';
import '../onboarding_screen.dart';

class ContentPageWidget extends StatefulWidget {
  const ContentPageWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.pageController,
    this.adId,
  }) : _pageController = pageController;

  final PageController _pageController;
  final AssetGenImage image;
  final String title;
  final String description;
  final String? adId;
  final PageController pageController;

  @override
  State<ContentPageWidget> createState() => _ContentPageWidgetState();
}

class _ContentPageWidgetState extends State<ContentPageWidget> {
  bool canNext = false;
  Timer? timer;

  void startTimer() {
    canNext = true;
    canNext = false;
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      canNext = true;
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValueCubit<int>, int>(
      builder: (context, currentIndex) {
        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (!canNext) {
              return;
            }
            if (details.delta.dx < 0) {
              if (currentIndex < 3) {
                _pressNextButton(currentIndex);
                startTimer();
              } else {
                _onStartedTap();
              }
            } else if (details.delta.dx > 0) {
              if (currentIndex > 0) {
                context.read<ValueCubit<int>>().update(currentIndex - 1);
                widget.pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    48.vSpace,
                    Flexible(
                      child: Image.asset(widget.image.path, fit: BoxFit.cover),
                    ),
                    24.vSpace,
                    buildDescription(),
                    20.vSpace,
                    PageAction(
                      pageController: widget.pageController,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 24.h, right: 24.h, left: 24.h),
                child: ButtonWidget(
                  onTap: () {
                    if (!canNext) {
                      return;
                    }
                    if (currentIndex < 3) {
                      _pressNextButton(currentIndex);
                      startTimer();
                    } else {
                      _onStartedTap();
                    }
                  },
                  child: Text(
                    currentIndex == 3
                        ? context.l10n.
                    cast_start
                        : context.l10n.next,
                    style: StyleUtils.style.white.bold.s16,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Column buildDescription() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        12.vSpace,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Text(
            widget.description,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _pressNextButton(int currentIndex) {
    if (currentIndex < 3) {
      context.read<ValueCubit<int>>().update(currentIndex + 1);
      if (currentIndex < 4) {
        widget._pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    }
  }

  Future<void> _onStartedTap() async {
    if (true) {
      context.replaceRoute(const PermissionRoute());
    }
  }
}
