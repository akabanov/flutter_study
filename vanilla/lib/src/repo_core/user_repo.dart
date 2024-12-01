import 'package:vanilla/src/repo_core/user_entity.dart';

abstract class UserRepo {
  Future<UserEntity> login();
}
