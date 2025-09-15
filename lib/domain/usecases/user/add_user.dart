import 'package:dartz/dartz.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class AddUser {
  final UserRepository repository;
  AddUser(this.repository);

  Future<Either<String, void>> call(User user) async {
    return await repository.addUser(user);
  }
}
