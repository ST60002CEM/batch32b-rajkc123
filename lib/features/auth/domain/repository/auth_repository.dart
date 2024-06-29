import 'package:dartz/dartz.dart';
import 'package:finalproject/core/common/internet_checker/internet_checker.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:finalproject/features/auth/data/repository/auth_remote_repository.dart';
import 'package:finalproject/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final checkConnectivity = ref.read(connectivityStatusProvider);
  if (checkConnectivity == ConnectivityStatus.isConnected) {
    return AuthRemoteRepository(
      ref.read(authRemoteDataSourceProvider),
    );
  } else {
    return AuthRemoteRepository(
      ref.read(authRemoteDataSourceProvider),
    );
  }
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerStudent(AuthEntity user);
  Future<Either<Failure, bool>> loginStudent(String email, String password);
  // Future<Either<Failure, AuthEntity>> getCurrentStudent();
}
