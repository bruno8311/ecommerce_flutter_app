import 'package:dartz/dartz.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

class GetUser {
  final UserRepository repository;
  GetUser(this.repository);

  Future<Either<String, User>> call(int id) async {
    return await repository.getUser(id);
  }
}
