import 'package:finalproject/features/practice/data/model/practice_task_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'practice_task_dto.g.dart';

@JsonSerializable()
class PracticeTaskDTO {
  final String? taskType;
  final String? imageUrl;
  final String? explanation;

  PracticeTaskDTO({
    this.taskType,
    this.imageUrl,
    this.explanation,
  });

  factory PracticeTaskDTO.fromJson(Map<String, dynamic> json) => _$PracticeTaskDTOFromJson(json);
  Map<String, dynamic> toJson() => _$PracticeTaskDTOToJson(this);

  PracticeTaskModel toModel() {
    return PracticeTaskModel(
      taskType: taskType ?? '',
      imageUrl: imageUrl ?? '',
      explanation: explanation ?? '',
    );
  }
}
