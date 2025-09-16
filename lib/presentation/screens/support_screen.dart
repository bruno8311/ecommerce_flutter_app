import 'package:atomic_desing_system_package/atomic_desing_system_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/user.dart';

class SupportScreen extends StatelessWidget {
  final User user;
  const SupportScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return TemplateContactPage(
      headerTitle: 'Soporte',
      headerUserName: user.username,
      headerUserImageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=687&auto=format&fit=crop',
      headerShowBackArrow: true,
      headerOnHome: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Home')));
      },
      headerOnLogout: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logout')));
      },
      descriptiveTitle: 'Soporte',
      descriptiveSubtitle:'¿Necesitas ayuda con tu compra, tienes problemas con la app o alguna otra consulta? Escríbenos y nuestro equipo de soporte te responderá lo antes posible.\n\nEmail: soporte@ecommerce.com\nTeléfono: +51 999 999 999',
      descriptiveButtonText: 'Enviar',
      descriptiveButtonDependsOnText: true,
      descriptiveOnButtonPressed: (text) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Se envió el mensaje: $text'))),
      footerIcons: const [Icons.facebook, Icons.email],
    );
  }
}
