import 'package:atomic_desing_system_package/atomic_desing_system_package.dart';
import 'package:flutter_ecommerce_app/presentation/screens/contact_screen.dart';
import 'package:flutter_ecommerce_app/presentation/screens/dashboard_screen.dart';
import 'package:flutter_ecommerce_app/presentation/screens/login_screen.dart';
import 'package:flutter_ecommerce_app/presentation/screens/support_screen.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/user.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final User user;
  const ProductDetailScreen({super.key, required this.product, required this.user});

  @override
  Widget build(BuildContext context) {

    return 

    TemplateDetailPage(
       headerUserImageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=687&auto=format&fit=crop',
       headerUserName: user.username,
       headerTitle: 'Detalles del Producto',
       headerOnLogout: () {
         Navigator.of(context).push(
           MaterialPageRoute(
             builder: (_) => const LoginScreen(),
           ),
         );
       },
       headerOnHome: () {
         Navigator.of(context).push(
           MaterialPageRoute(
             builder: (_) => DashboardScreen(user: user),
           ),
         );
       },
       productImageUrl: product.image,
       productTitle: product.title,
       productPrice: 'S/ ${product.price.toStringAsFixed(2)}',
       productCategory: product.category,
       productDescription: product.description,
       footerIcons: const [
          Icons.facebook,
          Icons.email,
        ],
        footerLabels: const ['Contacto', 'Ayuda'],
        footerActions: [
        () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ContactScreen(user: user),
            ),
          );
        },
        () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SupportScreen(user: user),
            ),
          );
        },
      ],
       );
    //   Scaffold(
    //    appBar: AppBar(
    //      title: Text(product.title),
    //    ),
    //    body: SingleChildScrollView(
    //      child: Padding(
    //        padding: const EdgeInsets.all(16.0),
    //        child: Column(
    //          crossAxisAlignment: CrossAxisAlignment.start,
    //          children: [
    //            Center(
    //              child: Image.network(
    //                product.image,
    //                height: 220,
    //                fit: BoxFit.contain,
    //              ),
    //            ),
    //            const SizedBox(height: 16),
    //            Text(
    //              product.title,
    //              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    //            ),
    //            const SizedBox(height: 8),
    //            Text(
    //              'S/ ${product.price.toStringAsFixed(2)}',
    //              style: const TextStyle(fontSize: 20, color: Colors.blueAccent, fontWeight: FontWeight.bold),
    //            ),
    //            const SizedBox(height: 8),
    //            Chip(label: Text(product.category)),
    //            const SizedBox(height: 16),
    //            Text(
    //              product.description,
    //              style: const TextStyle(fontSize: 16),
    //            ),
    //            const SizedBox(height: 24),
    //            SizedBox(
    //              width: double.infinity,
    //              child: ElevatedButton.icon(
    //                icon: const Icon(Icons.add_shopping_cart),
    //                label: const Text('Agregar al carrito'),
    //                onPressed: () {
    //                  // Aquí puedes agregar la lógica para añadir al carrito
    //                  // Redirigir a la pantalla del carrito
    //                  Navigator.of(context).push(
    //                    MaterialPageRoute(
    //                      builder: (_) => const CartScreen(),
    //                    ),
    //                  );
    //                },
    //              ),
    //            ),
    //          ],
    //        ),
    //      ),
    //    ),
    //  );
  }
}
