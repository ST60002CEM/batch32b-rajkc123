import 'package:finalproject/app/navigator_key/navigator_key.dart';
import 'package:flutter/material.dart';

void showMySnackBar({required String message, Color? color}) {
  final currentState = AppNavigator.navigatorKey.currentState;
  if (currentState != null && currentState.context != null) {
    ScaffoldMessenger.of(currentState.context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color ?? Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  } else {
    print('Cannot show SnackBar: currentState or context is null');
  }
}
