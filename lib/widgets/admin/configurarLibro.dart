// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:reserva_libros/components/alerts.dart';
import 'package:reserva_libros/models/libro.dart';
import 'package:reserva_libros/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:reserva_libros/widgets/admin/EditarLibro.dart';

class ConfigurarLibro extends StatefulWidget {
  final Libro libro;
  const ConfigurarLibro({super.key, required this.libro});

  @override
  State<ConfigurarLibro> createState() => _ConfigurarLibroState();
}

class _ConfigurarLibroState extends State<ConfigurarLibro> {
  @override
  void initState() {
    super.initState();
    if (widget.libro.status == 0) {
      setState(() {
        buttonText = "Activar libro";
      });
    }
  }

  bool isButtonDisabled = false;
  String buttonText = 'Desactivar libro';

  Future desactivar(context) async {
    int? book_id = widget.libro.Id_libro;

    setState(() {
      isButtonDisabled = true;
      buttonText = 'Desactivando...';
    });

    final res = await http.post(
      Uri.parse("${Ruta.ruta}/admin/desactivarLibro.php/?id=$book_id"),
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SuccessAlert(
            title: items['respuesta'],
            redirectRoute: '/dashboard',
          );
        },
      );
    }
  }

  Future activar(context) async {
    int? book_id = widget.libro.Id_libro;

    setState(() {
      isButtonDisabled = true;
      buttonText = 'Activando...';
    });

    final res = await http.post(
      Uri.parse("${Ruta.ruta}/admin/activarlibro.php/?id=$book_id"),
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SuccessAlert(
            title: items['respuesta'],
            redirectRoute: '/dashboard',
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobre este Libro"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        widget.libro.titulo,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        '${widget.libro.autor} (${widget.libro.ano_publicacion})',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      "Descripción",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      widget.libro.descripcion,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Editorial",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      widget.libro.editorial,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "ISBN",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      widget.libro.isbn,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Disponibles",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "${widget.libro.disponibles}",
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isButtonDisabled
                        ? null
                        : widget.libro.status == 0
                            ? () => activar(context)
                            : () => desactivar(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      backgroundColor: widget.libro.status == 0
                          ? Colors.blue.shade500
                          : Colors.red.shade500,
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditarLibro(libro: widget.libro),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      backgroundColor: Colors.green.shade500,
                    ),
                    child: const Text(
                      'Editar Libro',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
