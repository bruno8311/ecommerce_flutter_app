import 'package:dartz/dartz.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class GetAllUsers {
  final UserRepository repository;
  GetAllUsers(this.repository);

  Future<Either<String, List<User>>> call() async {
    return await repository.getAllUsers();
  }
}
