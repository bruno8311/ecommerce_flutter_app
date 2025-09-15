import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/usecases/user/get_all_users.dart';
import '../../domain/usecases/user/get_user.dart';
import '../../domain/usecases/user/add_user.dart';
import '../../domain/usecases/user/update_user.dart';
import '../../domain/usecases/user/delete_user.dart';

class UserProvider extends ChangeNotifier {
  late final GetAllUsers getAllUsersUseCase;
  late final GetUser getUserUseCase;
  late final AddUser addUserUseCase;
  late final UpdateUser updateUserUseCase;
  late final DeleteUser deleteUserUseCase;

  List<User> users = [];
  String? errorMessage;

  final UserRepositoryImpl _repository;

  UserProvider() : _repository = UserRepositoryImpl() {
    getAllUsersUseCase = GetAllUsers(_repository);
    getUserUseCase = GetUser(_repository);
    addUserUseCase = AddUser(_repository);
    updateUserUseCase = UpdateUser(_repository);
    deleteUserUseCase = DeleteUser(_repository);
  }

  Future<void> loadUsers() async {
    final result = await getAllUsersUseCase.call();
    result.fold(
      (error) {
        errorMessage = error;
        users = [];
      },
      (list) {
        errorMessage = null;
        users = list;
      },
    );
    notifyListeners();
  }
}
