// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:reserva_libros/components/BookForm.dart';
import 'package:http/http.dart' as http;
import 'package:reserva_libros/components/alerts.dart';
import 'package:reserva_libros/ruta.dart';
import 'dart:convert';

class AgregarLibro extends StatefulWidget {
  const AgregarLibro({super.key});

  @override
  State<AgregarLibro> createState() => _AgregarLibroState();
}

class _AgregarLibroState extends State<AgregarLibro> {
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
  String buttonText = 'Crear libro';

  Future regLibro(context) async {
    setState(() {
      isButtonDisabled = true;
      buttonText = 'Creando libro...';
    });

    final res = await http.post(
      Uri.parse("${Ruta.ruta}/admin/crearLibro.php"),
      body: {
        "id_libro": idController.text,
        "titulo": tituloController.text,
        "descripcion": descripcionController.text,
        "author": autorController.text,
        "editorial": autorController.text,
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
        buttonText = 'Crear libro';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Libro"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Agregar Libro',
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
                onSubmit: regLibro,
                tituloController: tituloController,
                descripcionController: descripcionController,
                autorController: autorController,
                editorialController: editorialController,
                ano_publicacionController: ano_publicacionController,
                disponible: disponible,
                isbn: isbn,
                isEditing: false,
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
