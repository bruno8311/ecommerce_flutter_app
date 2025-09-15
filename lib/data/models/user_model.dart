
class UserItemModel {
  final int id;
  final String username;
  final String email;
  final String password;

  const UserItemModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

   factory UserItemModel.fromJson(Map<String, dynamic> json) {
     return UserItemModel(
       id: json['id'],
       username: json['username'],
       email: json['email'],
       password: json['password'],
     );
   }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }
}