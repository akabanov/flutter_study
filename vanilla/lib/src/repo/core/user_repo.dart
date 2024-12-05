import 'package:vanilla/src/repo/core/user_entity.dart';

abstract class UserRepo {
  Future<UserEntity> login();
}
