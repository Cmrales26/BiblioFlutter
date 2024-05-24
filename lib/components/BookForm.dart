// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class BookForm extends StatelessWidget {
  final TextEditingController idController;
  final TextEditingController tituloController;
  final TextEditingController descripcionController;
  final TextEditingController autorController;
  final TextEditingController editorialController;
  final TextEditingController ano_publicacionController;
  final TextEditingController disponible;
  final TextEditingController isbn;
  final bool isEditing;
  final String buttonText;
  final bool buttonClick;
  final Function(BuildContext) onSubmit;

  const BookForm({
    super.key,
    required this.idController,
    required this.onSubmit,
    required this.tituloController,
    required this.descripcionController,
    required this.autorController,
    required this.editorialController,
    required this.ano_publicacionController,
    required this.disponible,
    required this.isbn,
    required this.isEditing,
    required this.buttonText,
    required this.buttonClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: idController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Id del Libro',
          ),
          keyboardType: TextInputType.number,
          enabled: !isEditing,
        ),
        const SizedBox(height: 30),
        TextField(
          controller: tituloController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Título',
          ),
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 30),
        TextField(
          controller: descripcionController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Descripción',
          ),
          keyboardType: TextInputType.text,
          maxLines: 5,
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextField(
                  controller: autorController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Autor',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: editorialController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Editorial',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextField(
                  controller: ano_publicacionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Año de publicación',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: disponible,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Disponible',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        TextField(
          controller: isbn,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'ISBN',
          ),
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: buttonClick ? null : () => onSubmit(context),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              backgroundColor: Colors.red.shade300,
            ),
            child: Text(
              buttonText,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
