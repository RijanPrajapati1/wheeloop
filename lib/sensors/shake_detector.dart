import 'dart:async';
import 'dart:math';

import 'package:sensors_plus/sensors_plus.dart';

class ShakeDetector {
  final Function onShake;
  final double shakeThreshold;

  StreamSubscription<AccelerometerEvent>? _streamSubscription;
  DateTime? _lastShake;

  ShakeDetector({
    required this.onShake,
    this.shakeThreshold = 3.0, // Default shake threshold
  });

  // Start listening for accelerometer events
  void startListening() {
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      double x = event.x;
      double y = event.y;
      double z = event.z;

      // Calculate the acceleration vector magnitude
      double acceleration = sqrt(x * x + y * y + z * z) - 9.8;

      DateTime now = DateTime.now();

      // Check for a significant shake (greater than the threshold)
      if (_lastShake == null ||
          now.difference(_lastShake!) > const Duration(milliseconds: 1000)) {
        if (acceleration > shakeThreshold) {
          _lastShake = now;
          onShake(); // Trigger the onShake callback
        }
      }
    });
  }

  // Stop listening to accelerometer events
  void stopListening() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
  }
}
