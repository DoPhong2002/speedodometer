part of '../onboarding_screen.dart';

class PageAction extends StatefulWidget {
  const PageAction({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  State<PageAction> createState() => _PageActionState();
}

class _PageActionState extends State<PageAction> {
  Timer? timer;
  bool canNext = false;

  ///Delay 1 khoảng thời gian giữa các lần nhấn next.
  void startTimer() {
    canNext = true;
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValueCubit<int>, int>(
      builder: (context, currentIndex) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomIndicator(
              length: 4,
              currentIndex: currentIndex,
            ),
            30.vSpace,
          ],
        );
      },
    );
  }
}
