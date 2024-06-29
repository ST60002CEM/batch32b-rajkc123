import 'package:dio/dio.dart';
import 'package:finalproject/app/constants/api_endpoint.dart';
import 'package:finalproject/features/practice/data/dto/practice_task_dto.dart';
import 'package:finalproject/features/practice/data/model/practice_task_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finalproject/core/failure/failure.dart';
import 'package:dartz/dartz.dart';


final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final practiceTaskRemoteDataSourceProvider = Provider<PracticeTaskRemoteDataSource>((ref) {
  return PracticeTaskRemoteDataSource(ref.watch(dioProvider));
});

class PracticeTaskRemoteDataSource {
  final Dio _dio;

  PracticeTaskRemoteDataSource(this._dio);

  Future<Either<Failure, List<PracticeTaskModel>>> getAllPracticeTasks() async {
    try {
      final response = await _dio.get('${ApiEndpoints.baseUrl}${ApiEndpoints.getAllPracticeTasks}');
      final data = (response.data['tasks'] as List).map((task) {
        final taskDto = PracticeTaskDTO.fromJson(task);
        return taskDto.toModel();
      }).toList();
      return right(data);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}