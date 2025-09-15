import 'package:dartz/dartz.dart';
import 'package:fake_store_api_package/fake_store_api_package.dart';
import 'package:fake_store_api_package/domain/entities/user.dart';
import '../models/user_model.dart';

class RemoteUserDatasource {
  Future<Either<String, UserItemModel>> getUser(int id) async {
    try {
      final result = await api.getUser(id);
      return result.fold(
        (err) => Left(err),
        (e) => Right(UserItemModel(
          id: e.id,
          email: e.email,
          username: e.username,
          password: e.password,
        )),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> createUser(UserItemModel user) async {
    try {
      final entity = User(
        id: user.id,
        email: user.email,
        username: user.username,
        password: user.password,
      );
      final result = await api.createUser(entity);
      return result.fold(
        (err) => Left(err),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> updateUser(UserItemModel user) async {
    try {
      final entity = User(
        id: user.id,
        email: user.email,
        username: user.username,
        password: user.password,
      );
      final result = await api.updateUser(entity);
      return result.fold(
        (err) => Left(err),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> deleteUser(int id) async {
    try {
      final result = await api.deleteUser(id);
      return result.fold(
        (err) => Left(err),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
  final FakeStoreApiPackage api = FakeStoreApiPackage();

  Future<Either<String, List<UserItemModel>>> getUsers() async {
    try {
      final result = await api.getUsers();
      return result.fold(
        (err) => Left(err),
        (data) => Right(data.map((e) => UserItemModel(
          id: e.id,
          email: e.email,
          username: e.username,
          password: e.password,
        )).toList()),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
