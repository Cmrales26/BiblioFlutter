// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:reserva_libros/components/alerts.dart';
import 'package:reserva_libros/models/libro.dart';
import 'package:reserva_libros/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ConfigurarLibro extends StatefulWidget {
  final Libro libro;
  const ConfigurarLibro({super.key, required this.libro});

  @override
  State<ConfigurarLibro> createState() => _ConfigurarLibroState();
}

class _ConfigurarLibroState extends State<ConfigurarLibro> {
  bool isReserved = false;

  @override
  void initState() {
    super.initState();
    checkReserva(context);
  }

  Future checkReserva(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final res = await http.post(
      Uri.parse("${Ruta.ruta}/user/CheckReserva.php"),
      body: {
        "id": prefs.getString('userId'),
        "book_id": widget.libro.Id_libro.toString()
      },
    );
    final items = json.decode(res.body);
    if (items.length > 0) {
      setState(() {
        isReserved = items['respuesta'];
      });
    }
  }

  Future reservar(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final res = await http.post(
      Uri.parse("${Ruta.ruta}/user/reservarLibro.php"),
      body: {
        "id": prefs.getString('userId'),
        "book_id": widget.libro.Id_libro.toString()
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
            redirectRoute: '/home',
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SuccessAlert(
            title: items['respuesta'],
            redirectRoute: '/home',
          );
        },
      );
    }
  }

  Future devolver(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdString = prefs.getString("userId");
    if (userIdString != null) {
      int id = int.parse(userIdString);

      int? book_id = widget.libro.Id_libro;

      final res = await http.delete(
        Uri.parse(
            "${Ruta.ruta}/user/DevolverLibro.php/?id=$id&lib_id=$book_id"),
      );

      final statusCode = res.statusCode;
      final items = json.decode(res.body);
      if (statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SuccessAlert(
              title: items['respuesta'],
              redirectRoute: '/home',
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SuccessAlert(
              title: items['respuesta'],
              redirectRoute: '/home',
            );
          },
        );
      }
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
          // Container(
          //   margin: const EdgeInsets.all(20),
          //   child: isReserved
          //       ? SizedBox(
          //           width: MediaQuery.of(context).size.width,
          //           child: ElevatedButton(
          //             onPressed: () {
          //               devolver(context);
          //             },
          //             style: ElevatedButton.styleFrom(
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(5.0),
          //               ),
          //               backgroundColor: Colors.red.shade200,
          //             ),
          //             child: const Text(
          //               'Devolver Libro',
          //               style: TextStyle(color: Colors.white),
          //             ),
          //           ),
          //         )
          //       : SizedBox(
          //           width: MediaQuery.of(context).size.width,
          //           child: ElevatedButton(
          //             onPressed: () {
          //               reservar(context);
          //             },
          //             style: ElevatedButton.styleFrom(
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(5.0),
          //               ),
          //               backgroundColor: Colors.blue.shade300,
          //             ),
          //             child: const Text(
          //               'Reservar Libro',
          //               style: TextStyle(color: Colors.white),
          //             ),
          //           ),
          //         ),
          // )
        ],
      ),
    );
  }
}
