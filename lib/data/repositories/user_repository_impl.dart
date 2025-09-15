import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/data/datasources/remote_user_datasource.dart';
import 'package:flutter_ecommerce_app/domain/mappers/user_mapper.dart';
import 'package:flutter_ecommerce_app/domain/entities/user.dart';
import 'package:flutter_ecommerce_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteUserDatasource _userApi = RemoteUserDatasource();

  @override
  Future<Either<String, List<User>>> getAllUsers() async {
    final result = await _userApi.getUsers();
    return result.fold(
      (error) => Left(error),
      (apiModels) => Right(apiModels.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<String, User>> getUser(int id) async {
    final result = await _userApi.getUser(id);
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<String, void>> addUser(User user) async {
  final model = user.toModel();
    final result = await _userApi.createUser(model);
    return result.fold(
      (error) => Left(error),
      (_) => const Right(null),
    );
  }

  @override
  Future<Either<String, void>> updateUser(User user) async {
  final model = user.toModel();
    final result = await _userApi.updateUser(model);
    return result.fold(
      (error) => Left(error),
      (_) => const Right(null),
    );
  }

  @override
  Future<Either<String, void>> deleteUser(int id) async {
    final result = await _userApi.deleteUser(id);
    return result.fold(
      (error) => Left(error),
      (_) => const Right(null),
    );
  }
}
