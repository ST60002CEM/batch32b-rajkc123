import 'package:finalproject/app/navigator/navigator.dart';
import 'package:finalproject/core/common/my_snackbar.dart';
import 'package:finalproject/features/auth/domain/entity/auth_entity.dart';
import 'package:finalproject/features/auth/domain/usecases/auth_usecase.dart';
import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart';
import 'package:finalproject/features/auth/presentation/state/auth_state.dart';
import 'package:finalproject/features/auth/presentation/view/register_view.dart';
import 'package:finalproject/features/home/presentation/navigator/home_navigator.dart';
import 'package:finalproject/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(ref.read(loginViewNavigatorProvider),
      ref.read(authUseCaseProvider), ref.read(homeViewNavigatorProvider)),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this.navigator, this.authUseCase, this.homeNavigator)
      : super(AuthState.initial());
  final AuthUseCase authUseCase;
  final LoginViewNavigator navigator;
  final HomeViewNavigator homeNavigator;

  Future<void> registerStudent(AuthEntity student) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.registerStudent(student);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: "Successfully registered");
      },
    );
  }

  loginStudent(
    String username,
    String password,
  ) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.loginStudent(username, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        openHomeView();
      },
    );
  }

  void openRegisterView() {
    NavigateRoute.pushRoute(const RegisterView());
  }

  void openHomeView() {
    NavigateRoute.pushRoute(const HomeView());
  }
}
