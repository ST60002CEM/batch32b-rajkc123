import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/auth/domain/entity/auth_entity.dart';
import 'package:finalproject/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



abstract class AuthRemoteRepository implements IAuthRepository {



  @override
  Future<Either<Failure, bool>> loginStudent(String username, String password) {
    // TODO: implement loginStudent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> registerStudent(AuthEntity student) {
    // TODO: implement registerStudent
    throw UnimplementedError();
  }

}