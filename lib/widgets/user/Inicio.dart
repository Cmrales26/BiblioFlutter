import 'package:flutter/material.dart';
import 'package:reserva_libros/components/AppBar.dart';
import 'package:reserva_libros/components/CardBook.dart';
import 'package:reserva_libros/models/libro.dart';
import 'package:reserva_libros/ruta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => InicioState();
}

class InicioState extends State<Inicio> {
  late Future<List<Libro>> libros;

  @override
  void initState() {
    super.initState();
    libros = getDisponibles();
    getPreferencias();
  }

  Future<List<Libro>> getDisponibles() async {
    final res = await http.get(
      Uri.parse("${Ruta.ruta}/listLibrosDisponible.php"),
    );

    final it = json.decode(res.body).cast<Map<String, dynamic>>();

    List<Libro> li = it.map<Libro>((json) {
      return Libro.fromJson(json);
    }).toList();

    return li;
  }

  String nombre = "";
  String apellido = "";

  Future<void> getPreferencias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userNombre = prefs.getString("userNombre");
    String? userApellido = prefs.getString("userApellido");

    if (userNombre != null && userApellido != null) {
      setState(() {
        nombre = userNombre;
        apellido = userApellido;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido/a $nombre $apellido"),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            const Text(
              "Libros Disponibles",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Libro>>(
                future: libros,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Libro>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No hay libros disponibles"),
                    );
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var datos = snapshot.data![index];
                      return CardBook(
                        datos: datos,
                        isAdmin: false,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
