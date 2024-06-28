import 'package:finalproject/app/navigator/navigator.dart';
import 'package:finalproject/features/home/presentation/view/home_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewNavigatorProvider = Provider((ref) => HomeViewNavigator());

class HomeViewNavigator {
  void openHomeView() {}
}

mixin HomeViewRoute {
  openHomeView() {
    NavigateRoute.pushRoute(const HomeView());
  }
}
