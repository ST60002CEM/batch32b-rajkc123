// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PracticeTaskModel _$PracticeTaskModelFromJson(Map<String, dynamic> json) =>
    PracticeTaskModel(
      taskType: json['taskType'] as String,
      imageUrl: json['imageUrl'] as String,
      explanation: json['explanation'] as String,
    );

Map<String, dynamic> _$PracticeTaskModelToJson(PracticeTaskModel instance) =>
    <String, dynamic>{
      'taskType': instance.taskType,
      'imageUrl': instance.imageUrl,
      'explanation': instance.explanation,
    };
