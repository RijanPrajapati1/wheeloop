import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'package:wheeloop/app/route_generator.dart';
import 'package:wheeloop/app/service_locator/service_locator.dart';
import 'package:wheeloop/core/network/hive_service.dart';
import 'package:wheeloop/sensors/gyro_sensors.dart';
import 'package:wheeloop/sensors/shake_detector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ShakeDetector shakeDetector;

  @override
  void initState() {
    super.initState();

    // Initialize ShakeDetector and restart app on shake
    shakeDetector = ShakeDetector(
      onShake: () {
        Restart.restartApp(); // Restart app when shake is detected
      },
    );

    shakeDetector.startListening();
  }

  @override
  void dispose() {
    shakeDetector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const GyroscopeTiltView(
      // Wrap the whole app in GyroscopeTiltView to apply the tilt effect
      child: RouteGenerator(),
    );
  }
}
