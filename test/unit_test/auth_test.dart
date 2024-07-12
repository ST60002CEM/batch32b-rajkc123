import 'package:dartz/dartz.dart';
import 'package:finalproject/features/auth/domain/usecases/auth_usecase.dart';
import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart';
import 'package:finalproject/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:finalproject/features/home/presentation/navigator/home_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


import 'auth_test.mocks.dart';


// TO CREATE THIS FILE USE
//COMMAND : dart run build_runner build

@GenerateNiceMocks([MockSpec<AuthUseCase>(), MockSpec<LoginViewNavigator>(),MockSpec<HomeViewNavigator>()])
void main() {
  late AuthUseCase mockAuthUsecase;
  late LoginViewNavigator mockLoginViewNavigator;
  late HomeViewNavigator mockHomeViewNavigator;

  late ProviderContainer container;

  setUp(() {
    mockAuthUsecase = MockAuthUseCase();
    mockLoginViewNavigator = MockLoginViewNavigator();
    mockHomeViewNavigator = MockHomeViewNavigator();

    TestWidgetsFlutterBinding.ensureInitialized();

    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith(
        (ref) => AuthViewModel(
          mockLoginViewNavigator,
          mockAuthUsecase,
          mockHomeViewNavigator

        ),
      )
    ]);
  });


  test('check for the initial state in Auth state', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
  });


    test('check for the initial state in Auth state', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, true);
    expect(authState.error, isNull);
  });







  
  tearDown(() {
    container.dispose();
  });
}
