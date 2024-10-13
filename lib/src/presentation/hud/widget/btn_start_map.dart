// import 'dart:math' as math;
//
// import 'package:flutter/material.dart';
//
// import '../../../shared/constants/app_colors.dart';
// import '../../../shared/extension/context_extension.dart';
// import '../../../utils/style_utils.dart';
//
// class BtnStartHub extends StatelessWidget {
//   const BtnStartHub({
//     super.key,
//     required this.callback,
//   });
//
//   final VoidCallback callback;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: AlignmentDirectional.center,
//       children: [
//         SizedBox(
//           height: 2,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: AppColors.dividerGradient,
//             ),
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             callback();
//           },
//           child: Container(
//             width: 43,
//             height: 200,
//             decoration: const BoxDecoration(
//               gradient: AppColors.buttonGradient,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(40),
//               ),
//             ),
//           ),
//         ),
//         Transform.rotate(
//           angle: math.pi / 2,
//           child: Text(
//             context.l10n.odometer,
//             style: StyleUtils.style.white.bold.s16,
//           ),
//         ),
//       ],
//     );
//   }
// }
