// Mocks generated by Mockito 5.4.4 from annotations
// in finalproject/test/unit_test/auth_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:finalproject/core/failure/failure.dart' as _i5;
import 'package:finalproject/features/auth/domain/entity/auth_entity.dart'
    as _i6;
import 'package:finalproject/features/auth/domain/usecases/auth_usecase.dart'
    as _i3;
import 'package:finalproject/features/auth/presentation/navigator/login_navigator.dart'
    as _i7;
import 'package:finalproject/features/home/presentation/navigator/home_navigator.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthUseCase extends _i1.Mock implements _i3.AuthUseCase {
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> registerStudent(
          _i6.AuthEntity? student) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerStudent,
          [student],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #registerStudent,
            [student],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #registerStudent,
            [student],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> loginStudent(
    String? username,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #loginStudent,
          [
            username,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #loginStudent,
            [
              username,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #loginStudent,
            [
              username,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
}

/// A class which mocks [LoginViewNavigator].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginViewNavigator extends _i1.Mock
    implements _i7.LoginViewNavigator {}

/// A class which mocks [HomeViewNavigator].
///
/// See the documentation for Mockito's code generation for more information.
class MockHomeViewNavigator extends _i1.Mock implements _i8.HomeViewNavigator {
  @override
  void openHomeView() => super.noSuchMethod(
        Invocation.method(
          #openHomeView,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void openPracticeView() => super.noSuchMethod(
        Invocation.method(
          #openPracticeView,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
