import 'package:finalproject/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_current_user_dto.g.dart';

@JsonSerializable()
class GetCurrentUserDto {
  @JsonKey(name:"_id")
  final String id;
  // final String fname;
  final String email;
  // final String phone;
  // final String image;
  final String username;
  // final String batch;
  // final List<String> course;

  GetCurrentUserDto({
    required this.id,
    // required this.fname,
    required this.email,
    // required this.phone,
    // required this.image,
    required this.username,
    // required this.batch,
    // required this.course,
  });

  AuthEntity toEntity() {
    return AuthEntity(
        id: id,
        // fname: fname,
        email: email,
        // image: image,
        // phone: phone,
        // batch: BatchEntity(batchId: id, batchName: ''),
        // courses:  course.map((course) {
        //   return CourseEntity( courseId: course, courseName: '');
        // }).toList() ,
        username: username,
        password: '');
  }

  factory GetCurrentUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetCurrentUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetCurrentUserDtoToJson(this);
}
