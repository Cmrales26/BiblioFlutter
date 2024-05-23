import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reserva_libros/components/UserForm.dart';
import 'package:reserva_libros/components/alerts.dart';
import 'package:reserva_libros/ruta.dart';
import 'dart:convert';

class Crear extends StatefulWidget {
  const Crear({super.key});

  @override
  State<Crear> createState() => _CrearState();
}

class _CrearState extends State<Crear> {
  TextEditingController idController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String genero = "Masculino";

  String error = '';
  bool isError = false;

  void GeneroCambio(String value) {
    setState(() {
      genero = value;
    });
  }

  Future regUsuario(context) async {
    final res = await http.post(
      Uri.parse("${Ruta.ruta}/user/creatcuenta.php"),
      body: {
        "id": idController.text,
        "nombre": nombreController.text,
        "apellido": apellidoController.text,
        "genero": genero,
        "correo": correoController.text,
        "telefono": telefonoController.text,
        "contraseña": passController.text,
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
            redirectRoute: '/',
          );
        },
      );
    } else {
      setState(() {
        error = items['respuesta'];
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: const Center(
                    child: Text(
                      'Crear Cuenta',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                isError
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(bottom: 20),
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
                UserForm(
                  idController: idController,
                  nombreController: nombreController,
                  apellidoController: apellidoController,
                  correoController: correoController,
                  telefonoController: telefonoController,
                  passController: passController,
                  genero: genero,
                  onSubmit: regUsuario,
                  isEditing: false,
                  cambioGenero: GeneroCambio,
                )
              ],
            ),
          ),
        ));
  }
}
