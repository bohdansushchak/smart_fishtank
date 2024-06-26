import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_fishtank/feature/theme/fishtank_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String path = '/splash';
  static const String name = 'splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = FishTankTheme.of(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: myTheme.backgroundGradient,
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
