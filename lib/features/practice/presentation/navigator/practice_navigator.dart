import 'package:flutter/material.dart';
import 'package:finalproject/app/navigator_key/navigator_key.dart';
import 'package:finalproject/features/practice/presentation/view/practice_view.dart';

class PracticeNavigator {
  PracticeNavigator._();

  static void goToPractice() {
    Navigator.push(
      AppNavigator.navigatorKey.currentState!.context,
      MaterialPageRoute(builder: (context) => const PracticeTaskView()),
    );
  }
}
