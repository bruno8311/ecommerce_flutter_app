import 'package:dartz/dartz.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<String, List<User>>> getAllUsers();
  Future<Either<String, User>> getUser(int id);
  Future<Either<String, void>> addUser(User user);
  Future<Either<String, void>> updateUser(User user);
  Future<Either<String, void>> deleteUser(int id);
}
