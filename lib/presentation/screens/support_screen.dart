import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Soporte')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Centro de Soporte', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('¿Tienes algún problema o duda?'),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Describe tu problema',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tu solicitud de soporte ha sido enviada.')),
                  );
                },
                child: const Text('Enviar'),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Preguntas frecuentes:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('- ¿Cómo puedo rastrear mi pedido?'),
            const Text('- ¿Cómo solicito un reembolso?'),
            const Text('- ¿Cómo cambio mi contraseña?'),
          ],
        ),
      ),
    );
  }
}
