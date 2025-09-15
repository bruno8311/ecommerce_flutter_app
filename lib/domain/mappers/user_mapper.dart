import '../entities/user.dart';
import '../../data/models/user_model.dart';

extension UserMapper on User {
  UserItemModel toModel() => UserItemModel(
    id: id,
    username: username,
    email: email,
    password: password,
  );
}

extension UserItemModelMapper on UserItemModel {
  User toEntity() => User(
    id: id,
    username: username,
    email: email,
    password: password,
  );
}

