import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart'; // Import Local Authentication
import '../../config/navigation/app_router.dart';
import '../../gen/assets.gen.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../utils/style_utils.dart';
import '../../widgets/gps_background.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  // ···

  /// Chuyển đến màn hình tiếp theo sau khi xác thực thành công
  Future<void> setInitScreen() async {
    context.replaceRoute(LanguageRoute(isFirst: true));
  }

  /// Hàm thực hiện xác thực sinh trắc học
  Future<bool> _authenticate() async {
    final bool canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();
    bool authenticated = false;
    try {
      authenticated = await _localAuth.authenticate(
        localizedReason: "Please authenticate to continue",
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      print("Authentication error: $e");
    }
    return authenticated;
  }

  /// Khởi tạo màn hình với xác thực
  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 1));
    bool isAuthenticated = await _authenticate();
    if (isAuthenticated) {
      setInitScreen();
    } else {
      _showAuthFailedDialog();
    }
  }

  /// Hiển thị Dialog khi xác thực thất bại
  void _showAuthFailedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Authentication Failed"),
        content: const Text("You need to authenticate to use this app."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _init();
            },
            child: const Text("Retry"),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
              _exitApp();
            },
            child: const Text("Exit"),
          ),
        ],
      ),
    );
  }

  /// Thoát ứng dụng nếu người dùng hủy xác thực
  void _exitApp() {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return GpsBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Image.asset(
                        Assets.images.logo.roundedLogo.path,
                        width: 215,
                        height: 215,
                        fit: BoxFit.contain,
                      ),
                    ),
                    16.vSpace,
                    Text(context.l10n.gpsSpeedometer,
                        style: StyleUtils.style.white.s24.semiBold),
                    Text(context.l10n.tracker,
                        style: StyleUtils.style.white.s36.semiBold),
                  ],
                ),
              ),
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 36,
                  width: 36,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeCap: StrokeCap.round,
                    strokeWidth: 6,
                  ),
                ),
              ],
            ),
            40.vSpace,
          ],
        ),
      ),
    );
  }
}
