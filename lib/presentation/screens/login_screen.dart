import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'package:atomic_desing_system_package/atomic_desing_system_package.dart';
import 'dashboard_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar los usuarios al iniciar la pantalla
    Future.microtask(() {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.loadUsers();
    });
  }

  void _handleLogin(BuildContext context, String email, String password) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userList = userProvider.users.where(
      (u) => u.email == email && u.password == password,
    ).toList();

    if (userList.isNotEmpty) {
      final user = userList.first;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Bienvenido, ${user.username}!')),
      );
      // Navegar al dashboard y pasar el usuario
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => DashboardScreen(user: user),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateLoginPage(
      title: 'Bienvenido',
      subtitle: 'Inicia sesión para continuar',
      showBackArrow: true,
      onLogin: (email, password) => _handleLogin(context, email, password),
      onForgotPassword: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Olvidaste tu contraseña')),
        );
      },
    );
  }
}