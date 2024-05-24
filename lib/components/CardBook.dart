import 'package:flutter/material.dart';
import 'package:reserva_libros/models/libro.dart';
import 'package:reserva_libros/widgets/admin/configurarLibro.dart';
import 'package:reserva_libros/widgets/user/reservarLibro.dart';

class CardBook extends StatelessWidget {
  final Libro datos;
  final bool isAdmin;
  const CardBook({
    super.key,
    required this.datos,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: datos.status == 0 ? Colors.grey.shade300 : null,
      child: ListTile(
        title: Opacity(
          opacity: datos.status == 0 ? 0.5 : 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (datos.status == 0)
                const Text(
                  "Desactivado",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 8),
              Text(
                datos.titulo,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              Text(
                "Autor: ${datos.autor}",
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              Text(
                datos.disponibles == 0
                    ? "Agotado"
                    : "Disponibles: ${datos.disponibles}",
                style: TextStyle(
                  fontSize: 14,
                  color: datos.disponibles == 0 ? Colors.red : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        onTap: () {
          if (isAdmin) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfigurarLibro(libro: datos),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetallesLibro(libro: datos),
              ),
            );
          }
        },
      ),
    );
  }
}
