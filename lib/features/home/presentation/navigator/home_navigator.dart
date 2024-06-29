import 'package:finalproject/app/navigator/navigator.dart';
import 'package:finalproject/features/home/presentation/view/home_view.dart';
import 'package:finalproject/features/practice/presentation/view/practice_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewNavigatorProvider = Provider((ref) => HomeViewNavigator());

class HomeViewNavigator {
  void openHomeView() {
    NavigateRoute.pushRoute(const HomeView());
  }

  void openPracticeView() {
    NavigateRoute.pushRoute(const PracticeTaskView());
  }
}

mixin HomeViewRoute {
  openHomeView() {
    NavigateRoute.pushRoute(const HomeView());
  }

  openPracticeView() {
    NavigateRoute.pushRoute(const PracticeTaskView());
  }
}
