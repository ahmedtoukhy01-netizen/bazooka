import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String name;
  
  @HiveField(1)
  int age;
  
  @HiveField(2)
  String email;
  
  @HiveField(3)
  String uid;

  UserModel({
    required this.name,
    required this.age,
    required this.email,
    required this.uid,
  });
}