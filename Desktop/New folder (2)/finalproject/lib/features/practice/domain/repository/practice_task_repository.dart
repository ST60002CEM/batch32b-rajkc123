import 'package:dartz/dartz.dart';
import 'package:finalproject/features/practice/domain/entity/practice_task_entity.dart';
import 'package:finalproject/core/failure/failure.dart';

abstract class PracticeTaskRepositoryInterface {
  Future<Either<Failure, List<PracticeTaskEntity>>> getAllPracticeTasks();
}
