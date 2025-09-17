import 'package:atomic_desing_system_package/atomic_desing_system_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/user.dart';
import 'package:flutter_ecommerce_app/presentation/screens/dashboard_screen.dart';
import 'package:flutter_ecommerce_app/presentation/screens/login_screen.dart';

class ContactScreen extends StatelessWidget {
  final User user;
  final String? userTitle;
  final String? descriptionTitle;
  final String? descriptionSubtitle;
  const ContactScreen({super.key, required this.user, this.userTitle, this.descriptionTitle, this.descriptionSubtitle});

  @override
  Widget build(BuildContext context) {
    return TemplateContactPage(
      headerTitle: userTitle ?? '',
      headerUserName: user.username,
      headerUserImageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=687&auto=format&fit=crop',
      headerShowBackArrow: true,
      headerOnHome: () {
         Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DashboardScreen(user: user)
        ));
      },
      headerOnLogout: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => LoginScreen()
        ));
      },
      descriptiveTitle: descriptionTitle ?? '',
      descriptiveSubtitle: descriptionSubtitle ?? '',
      descriptiveButtonText: 'Enviar',
      descriptiveButtonDependsOnText: true,
      descriptiveOnButtonPressed: (text) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Se envió el mensaje: $text'))),
      footerIcons: const [Icons.facebook, Icons.email],
    );
  }
}
