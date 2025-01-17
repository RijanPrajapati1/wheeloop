import 'package:flutter/material.dart';
import 'package:wheeloop/app/route_generator.dart';
import 'package:wheeloop/app/service_locator/service_locator.dart';
import 'package:wheeloop/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await initDependencies();
  runApp(
    const RouteGenerator(),
  );
}
