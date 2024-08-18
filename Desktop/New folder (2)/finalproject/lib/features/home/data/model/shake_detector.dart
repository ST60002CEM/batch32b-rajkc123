import 'dart:async';
import 'dart:math'; // Add this line

import 'package:sensors_plus/sensors_plus.dart';


class ShakeDetector {
  final void Function() onPhoneShake;
  static const double shakeThresholdGravity = 2.7;
  static const int shakeSlopTimeMs = 500;
  static const int shakeCountResetTimeMs = 3000;

  int _shakeCount = 0;
  int _shakeTimestamp = DateTime.now().millisecondsSinceEpoch;

  StreamSubscription<UserAccelerometerEvent>? _streamSubscription;

  ShakeDetector({required this.onPhoneShake});

  void startListening() {
    // ignore: deprecated_member_use
    _streamSubscription = userAccelerometerEvents.listen((event) {
      double gX = event.x / 9.81;
      double gY = event.y / 9.81;
      double gZ = event.z / 9.81;

      double gForce = sqrt(gX * gX + gY * gY + gZ * gZ); // Use sqrt function from dart:math

      if (gForce > shakeThresholdGravity) {
        int now = DateTime.now().millisecondsSinceEpoch;
        if (_shakeTimestamp + shakeSlopTimeMs > now) {
          return;
        }

        if (_shakeTimestamp + shakeCountResetTimeMs < now) {
          _shakeCount = 0;
        }

        _shakeTimestamp = now;
        _shakeCount++;

        onPhoneShake();
      }
    });
  }

  void stopListening() {
    _streamSubscription?.cancel();
  }
}