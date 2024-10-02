// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../../../config/di/di.dart';
// import '../../../../gen/assets.gen.dart';
// import '../../../../utils/style_utils.dart';
// import '../../../map/cubit/speed_cubit.dart';
//
// class Theme3 extends StatefulWidget {
//   const Theme3({
//     super.key,
//   });
//
//   @override
//   State<Theme3> createState() => _Theme3State();
// }
//
// class _Theme3State extends State<Theme3> {
//   double max = 20;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SpeedCubit, SpeedState>(
//       bloc: getIt<SpeedCubit>(),
//       builder: (context, state) {
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Stack(
//             children: [
//               SizedBox(
//                 height: 1.sw, //1.sh when horizontal
//                 child: Image.asset(
//                   Assets.images.odometer.theme0.theme0.path,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               Positioned.fill(
//                 child: Center(
//                   child: BlocBuilder<SpeedCubit, SpeedState>(
//                       builder: (context, state) {
//                         var velocity = state.speed;
//                         if (velocity < 0) velocity = 0.0;
//                         final turn = velocity > 200 ? 200 : velocity;
//                         const oneKm = 0.077 / 48;
//                         return AnimatedRotation(
//                           turns: -0.305 + oneKm * turn,
//                           duration: const Duration(milliseconds: 3000),
//                         child: Transform.translate(
//                           offset: const Offset(-10, -30),
//                           child: SvgPicture.asset(
//                             Assets.images.odometer.theme1.icCursor.path,
//                             width: 15,
//                             height: 180,
//                           ),
//                         ),
//                       );
//                     }
//                   ),
//                 ),
//               ),
//               /*Positioned.fill(
//                 child: Center(
//                   child: Assets.images.imgCenterDial1.image(
//                     height: 100,
//                     fit: BoxFit.scaleDown,
//                   ),
//                 ),
//               )*/
//
//               Positioned.fill(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         '${state.speed.toInt()}',
//                         style: StyleUtils.style.white.bold.copyWith(
//                             height: 1, fontSize: state.speed > 1000 ? 80 : 96),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 100,
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                   child: Text(
//                     'Km/h',
//                     style: StyleUtils.style.white.regular.s16,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
