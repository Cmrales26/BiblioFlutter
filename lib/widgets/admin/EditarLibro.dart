// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:reserva_libros/components/BookForm.dart';
import 'package:http/http.dart' as http;
import 'package:reserva_libros/components/alerts.dart';
import 'package:reserva_libros/models/libro.dart';
import 'package:reserva_libros/ruta.dart';
import 'dart:convert';

class EditarLibro extends StatefulWidget {
  final Libro libro;

  const EditarLibro({super.key, required this.libro});

  @override
  State<EditarLibro> createState() => _EditarLibroState();
}

class _EditarLibroState extends State<EditarLibro> {
  TextEditingController idController = TextEditingController();
  TextEditingController tituloController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController autorController = TextEditingController();
  TextEditingController editorialController = TextEditingController();
  TextEditingController ano_publicacionController = TextEditingController();
  TextEditingController disponible = TextEditingController();
  TextEditingController isbn = TextEditingController();

  String error = '';
  bool isError = false;

  bool isButtonDisabled = false;
  String buttonText = 'Editar libro';

  @override
  void initState() {
    super.initState();
    getLibro();
  }

  Future editLibro(context) async {
    setState(() {
      isButtonDisabled = true;
      buttonText = 'Editando Libro...';
    });
    final res = await http.post(
      Uri.parse("${Ruta.ruta}/admin/EditarLibro.php"),
      body: {
        "id_libro": idController.text,
        "titulo": tituloController.text,
        "descripcion": descripcionController.text,
        "author": autorController.text,
        "editorial": editorialController.text,
        "ano_publicacion": ano_publicacionController.text,
        "disponible": disponible.text,
        "isbn": isbn.text,
      },
    );
    final statusCode = res.statusCode;
    final items = json.decode(res.body);

    if (statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SuccessAlert(
            title: items['respuesta'],
            redirectRoute: '/dashboard',
          );
        },
      );
    } else {
      setState(() {
        error = items['respuesta'];
        isError = true;
        isButtonDisabled = false;
        buttonText = 'Editar libro';
      });
    }
  }

  Future<void> getLibro() async {
    setState(() {
      idController.text = widget.libro.Id_libro.toString();
      tituloController.text = widget.libro.titulo;
      descripcionController.text = widget.libro.descripcion;
      autorController.text = widget.libro.autor;
      editorialController.text = widget.libro.editorial;
      ano_publicacionController.text = widget.libro.ano_publicacion.toString();
      disponible.text = widget.libro.disponibles.toString();
      isbn.text = widget.libro.isbn.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Libro"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Editar Libro',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              isError
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          error,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 40,
              ),
              BookForm(
                idController: idController,
                onSubmit: editLibro,
                tituloController: tituloController,
                descripcionController: descripcionController,
                autorController: autorController,
                editorialController: editorialController,
                ano_publicacionController: ano_publicacionController,
                disponible: disponible,
                isbn: isbn,
                isEditing: true,
                buttonText: buttonText,
                buttonClick: isButtonDisabled,
              )
            ],
          ),
        ),
      ),
    );
  }
}
