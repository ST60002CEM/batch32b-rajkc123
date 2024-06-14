import 'package:finalproject/app/constants/hive_table_constant.dart';
import 'package:finalproject/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

// TO CREATE THIS FILE USE
//COMMAND : dart run build_runner build -d

final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.studentTableId)
class AuthHiveModel {
  @HiveField(0)
  final String studentId;

  @HiveField(1)
  final String email;

  // @HiveField(2)
  // final String lname;

  // @HiveField(3)
  // final String phone;

  @HiveField(6)
  final String username;

  @HiveField(7)
  final String password;

  // Constructor
  AuthHiveModel({
    String? studentId,
    required this.email,
    // required this.lname,
    // required this.phone,
    required this.username,
    required this.password,
  }) : studentId = studentId ?? const Uuid().v4();

  // empty constructor
  AuthHiveModel.empty()
      : this(
          studentId: '',
          email: '',
          // lname: '',
          // phone: '',
          username: '',
          password: '',
        );

  // Convert Hive Object to Entity
  AuthEntity toEntity() => AuthEntity(
        id: studentId,
        email: email,
        // fname: fname,
        // lname: lname,
        // phone: phone,
        username: username,
        password: password,
      );

  // Convert Entity to Hive Object
  AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
        studentId: const Uuid().v4(),
        // fname: entity.fname,
        // lname: entity.lname,
        // phone: entity.phone,
        email: entity.email,
        username: entity.username,
        password: entity.password,
      );

  // Convert Entity List to Hive List
  List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'studentId: $studentId, email: $email, username: $username, password: $password';
  }
}
