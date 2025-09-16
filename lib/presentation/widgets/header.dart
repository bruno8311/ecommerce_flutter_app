import 'package:atomic_desing_system_package/atomic_desing_system_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/user.dart';
import 'package:flutter_ecommerce_app/presentation/screens/dashboard_screen.dart';
import 'package:flutter_ecommerce_app/presentation/screens/login_screen.dart';

class AppHeader extends StatelessWidget {
  final User user;

  const AppHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return OrganismHeaderWithoutSearch(
      userName: user.username,
      imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=687&auto=format&fit=crop',
      showBackArrow: true,
      onHome: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DashboardScreen(user: user)
        ));
      },
      onLogout: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
      title: 'Catálogo',
    );
  }
}
