import 'package:dartz/dartz.dart';
import '../../repositories/user_repository.dart';

class DeleteUser {
  final UserRepository repository;
  DeleteUser(this.repository);

  Future<Either<String, void>> call(int id) async {
    return await repository.deleteUser(id);
  }
}
