// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PracticeTaskDTO _$PracticeTaskDTOFromJson(Map<String, dynamic> json) =>
    PracticeTaskDTO(
      taskType: json['taskType'] as String?,
      imageUrl: json['imageUrl'] as String?,
      explanation: json['explanation'] as String?,
    );

Map<String, dynamic> _$PracticeTaskDTOToJson(PracticeTaskDTO instance) =>
    <String, dynamic>{
      'taskType': instance.taskType,
      'imageUrl': instance.imageUrl,
      'explanation': instance.explanation,
    };
