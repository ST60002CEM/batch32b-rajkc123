import 'package:dartz/dartz.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/practice/data/data_source/remote/practice_task_remote_data_source.dart';
import 'package:finalproject/features/practice/domain/entity/practice_task_entity.dart';
import 'package:finalproject/features/practice/domain/repository/practice_task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final practiceTaskRepositoryProvider = Provider<PracticeTaskRepository>((ref) {
  return PracticeTaskRepository(
      ref.watch(practiceTaskRemoteDataSourceProvider));
});

class PracticeTaskRepository implements PracticeTaskRepositoryInterface {
  final PracticeTaskRemoteDataSource remoteDataSource;

  PracticeTaskRepository(this.remoteDataSource);

  @override
  Future<Either<Failure, List<PracticeTaskEntity>>>
      getAllPracticeTasks() async {
    final result = await remoteDataSource.getAllPracticeTasks();
    return result.fold(
      (failure) => left(failure),
      (tasks) => right(tasks.map((model) => model.toEntity()).toList()),
    );
  }
}
