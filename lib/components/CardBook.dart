import 'package:flutter/material.dart';
import 'package:reserva_libros/models/libro.dart';
import 'package:reserva_libros/widgets/user/reservarLibro.dart';

class CardBook extends StatelessWidget {
  const CardBook({
    super.key,
    required this.datos,
  });

  final Libro datos;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // padding: const EdgeInsets.all(8),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              datos.titulo,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Autor: ${datos.autor}",
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Disponibles: ${datos.disponibles}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetallesLibro(libro: datos)),
          );
        },
      ),
    );
  }
}
