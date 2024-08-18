import 'package:dartz/dartz.dart';
import 'package:finalproject/app/navigator_key/navigator_key.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/auth/domain/entity/auth_entity.dart';
import 'package:finalproject/features/auth/domain/usecases/auth_usecase.dart';
import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart';
import 'package:finalproject/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:finalproject/features/home/presentation/navigator/home_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';

// TO CREATE THIS FILE USE
//COMMAND : dart run build_runner build



//COMMAND to test using Coverage=====================================================================

// flutter test --coverage   (for whole test coverage)
// flutter test ./test/unit_test/ --coverage       (for individual coverage)



//command to display test code coverage 
//flutter pub run test_cov_console


// Annotations to generate mock classes for the specified classes
@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
  MockSpec<HomeViewNavigator>()
])
void main() {
  // Declare variables for mock objects
  late AuthUseCase mockAuthUsecase;
  late LoginViewNavigator mockLoginViewNavigator;
  late HomeViewNavigator mockHomeViewNavigator;

  late ProviderContainer container; // Provider container for managing state

  setUp(() {
    // Initialize mock objects
    mockAuthUsecase = MockAuthUseCase();
    mockLoginViewNavigator = MockLoginViewNavigator();
    mockHomeViewNavigator = MockHomeViewNavigator();

    // Ensure Flutter bindings are initialized
    TestWidgetsFlutterBinding.ensureInitialized();

    // Override providers with mock implementations
    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith(
        (ref) => AuthViewModel(
            mockLoginViewNavigator, mockAuthUsecase, mockHomeViewNavigator),
      )
    ]);
  });

  // Group of tests for AuthState
  group("Authstate testing", () {
    // Test initial state of AuthViewModel
    test('check for the initial state in Auth state', () {
      final authState = container.read(authViewModelProvider);
      expect(authState.isLoading, false); // Initially, loading should be false
      expect(authState.error, isNull); // Initially, there should be no error
    });

    // Test initial state of AuthViewModel with an expected failure
    test('checking for the initial state in Auth state to fail', () {
      final authState = container.read(authViewModelProvider);
      expect(authState.isLoading,
          true); // This expectation is incorrect and will fail
      expect(authState.error, isNull); // Initially, there should be no error
    });
  });

  // Group of tests for Login functionality//////////////////////////////////////
  group("Login testing", () {
    // Test login with valid credentials
    testWidgets('login test with valid username and password', (WidgetTester tester) async {
    // Arrange
    const correctUsername = 'rajkc';
    const correctPassword = 'rajkc123';

    // Mock the loginStudent method to return Right(true) for correct credentials
    when(mockAuthUsecase.loginStudent(any, any)).thenAnswer((invocation) {
      final username = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
          username == correctUsername && password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Invalid')));
    });

    // Set up a MaterialApp for testing with the navigatorKey
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          home: Scaffold(body: Container()),
        ),
      ),
    );

    // Act
    await container
        .read(authViewModelProvider.notifier)
        .loginStudent('rajkc', 'rajkc123');

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull); // No error should occur for valid credentials
  });;

  test('login test with invalid username and password', () async {
    // Arrange
    when(mockAuthUsecase.loginStudent('rajkc1', 'rajkc123')).thenAnswer(
        (_) => Future.value(Left(Failure(error: 'Invalid Credentials'))));

    // Act
    await container
        .read(authViewModelProvider.notifier)
        .loginStudent('rajkc', 'rajkc123');

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, 'Invalid Credentials');
  });

  });

  test('Register User', () async {
    // Arrange
    const user = AuthEntity(
      email: 'test@example.com',
      username: 'testuser',
      password: 'password123',
    );

    when(mockAuthUsecase.registerStudent(user))
        .thenAnswer((_) => Future.value(const Right(true)));

    // Act
    await container.read(authViewModelProvider.notifier).registerStudent(user);

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
  });

  // Clean up after each test
  tearDown(() {
    container.dispose();
  });
}
