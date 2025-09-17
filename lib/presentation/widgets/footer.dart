import 'package:atomic_desing_system_package/atomic_desing_system_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/user.dart';
import 'package:flutter_ecommerce_app/presentation/screens/contact_screen.dart';

class AppFooter extends StatelessWidget {
  final User user;
  const AppFooter({
    super.key,
    required this.user
  });

  @override
  Widget build(BuildContext context) {
    return OrganismFooter(
      icons: [Icons.facebook, Icons.email],
      labels: const ['Contacto', 'Ayuda'],
      copyright: '© 2025 Mi Empresa. Todos los derechos reservados.',
      actions: [
        () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ContactScreen(user: user, userTitle: 'Contactanos', descriptionTitle: 'Siguenos en nuestras redes sociales', descriptionSubtitle: 'Email: soporte@ecommerce.com\nFacebook: facebook.com/ecommerce\nInstagram: instagram.com/ecommerce\n Dejanos un comentario:',),
            ),
          );
        },
        () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ContactScreen(user: user, userTitle: 'Soporte', descriptionTitle: '¿Tienes algun inconveniente con el sistema?', descriptionSubtitle: 'Linea telefónica para soporte en linea:\n Teléfono: +51 999 999 999\n Escribe tu problema y te ayudaremos lo antes posible.'),
            ),
          );
        },
      ],
    );
  }
}
