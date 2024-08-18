import 'package:dartz/dartz.dart';
import 'package:finalproject/features/practice/data/repository/practice_task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:finalproject/features/practice/domain/entity/practice_task_entity.dart';
import 'package:finalproject/features/practice/domain/repository/practice_task_repository.dart';

final getAllPracticeTasksProvider = Provider<GetAllPracticeTasks>((ref) {
  return GetAllPracticeTasks(ref.watch(practiceTaskRepositoryProvider));
});

class GetAllPracticeTasks {
  final PracticeTaskRepositoryInterface repository;

  GetAllPracticeTasks(this.repository);

  Future<Either<Failure, List<PracticeTaskEntity>>> call() async {
    return await repository.getAllPracticeTasks();
  }
}
