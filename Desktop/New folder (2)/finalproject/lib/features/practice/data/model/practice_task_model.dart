import 'package:finalproject/features/practice/domain/entity/practice_task_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'practice_task_model.g.dart';

@JsonSerializable()
class PracticeTaskModel {
  final String taskType;
  final String imageUrl;
  final String explanation;

  PracticeTaskModel({
    required this.taskType,
    required this.imageUrl,
    required this.explanation,
  });

  factory PracticeTaskModel.fromJson(Map<String, dynamic> json) => _$PracticeTaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$PracticeTaskModelToJson(this);

  PracticeTaskEntity toEntity() {
    return PracticeTaskEntity(
      taskType: taskType,
      imageUrl: imageUrl,
      explanation: explanation,
    );
  }
}
