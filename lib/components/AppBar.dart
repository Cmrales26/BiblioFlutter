import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

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
            onPressed: () {},
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
