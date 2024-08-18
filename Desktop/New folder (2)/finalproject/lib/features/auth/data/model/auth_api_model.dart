import 'package:finalproject/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String id;
  final String email;
  // final String lname;
  // final String? image;
  // final String phone;
  // final BatchApiModel batch;
  // final List<CourseApiModel> courses;
  final String username;
  final String? password;

  AuthApiModel({
    required this.id,
    required this.email,
    // required this.lname,
    // required this.image,
    // required this.phone,
    // required this.batch,
    // required this.courses,
    required this.username,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      email: email,
      // lname: lname,
      // image: image,
      // phone: phone,
      // batch: batch.toEntity(),
      // courses: courses.map((e) => e.toEntity()).toList(),
      username: username,
      password: password ?? '',
    );
  }
}
