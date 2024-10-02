import 'package:flutter/cupertino.dart';

class GradientBorder extends StatelessWidget {
  const GradientBorder(
      {super.key,
      required this.child,
      required this.gradient,
      required this.borderRadius});

  final Widget child;
  final Gradient gradient;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientCustom(gradient: gradient, borderRadius: borderRadius),
      child: child,
    );
  }
}

class GradientCustom extends CustomPainter {
  GradientCustom({
    required this.gradient,
    required this.borderRadius,
  });

  final Gradient gradient;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final RRect outer =
        RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final RRect inner = outer.deflate(1.5);
    final Paint paint = Paint()..shader = gradient.createShader(rect);

    canvas.drawDRRect(outer, inner, paint);
  }

  @override
  bool shouldRepaint(covariant GradientCustom oldDelegate) {
    return oldDelegate.gradient != gradient ||
        oldDelegate.borderRadius != borderRadius;
  }
}
