import 'package:flutter/material.dart';

class AdminBar extends StatelessWidget {
  const AdminBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/home");
            },
          ),
          IconButton(
            icon: const Icon(Icons.library_books),
            onPressed: () {
              // Navega a la página de lista de libros
              Navigator.pushNamed(context, "/books");
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navega a la página de agregar libros
              Navigator.pushNamed(context, "/addBook");
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navega a la página de editar/deshabilitar libros
              Navigator.pushNamed(context, "/editBook");
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, "/perfil");
            },
          ),
        ],
      ),
    );
  }
}
