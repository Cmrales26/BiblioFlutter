import 'package:flutter/material.dart';
import 'package:reserva_libros/components/UserForm.dart';
import 'package:reserva_libros/components/alerts.dart';
import 'package:reserva_libros/ruta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  TextEditingController idController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String genero = "";

  String error = '';
  bool isError = false;

  bool isButtonDisabled = false;
  String buttonText = 'Editar Cuenta';

  void generoCambio(String value) {
    setState(() {
      genero = value;
    });
  }

  Future editUsuario(context) async {
    setState(() {
      isButtonDisabled = true;
      buttonText = 'Editando...';
    });
    final res = await http.post(
      Uri.parse("${Ruta.ruta}/user/EditarUsuario.php"),
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      await prefs.setString('userId', idController.text);
      await prefs.setString('userNombre', nombreController.text);
      await prefs.setString('userApellido', apellidoController.text);
      await prefs.setString('userGenero', genero);
      await prefs.setString('userCorreo', correoController.text);
      await prefs.setString('userTelefono', telefonoController.text);
      await prefs.setString('rol', "usuario");

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
        isButtonDisabled = false;
        buttonText = 'Editar Cuenta';
      });
    }
  }

  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? userNombre = prefs.getString("userNombre");
    String? userApellido = prefs.getString("userApellido");
    String? userGenero = prefs.getString("userGenero");
    String? userCorreo = prefs.getString("userCorreo");
    String? userTelefono = prefs.getString("userTelefono");
    String? userRol = prefs.getString("rol");

    if (userId != null &&
        userNombre != null &&
        userApellido != null &&
        userGenero != null &&
        userCorreo != null &&
        userTelefono != null &&
        userRol != null) {
      setState(() {
        idController.text = userId;
        nombreController.text = userNombre;
        apellidoController.text = userApellido;
        genero = userGenero;
        correoController.text = userCorreo;
        telefonoController.text = userTelefono;
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
                      'Editar Cuenta',
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
                  onSubmit: editUsuario,
                  isEditing: true,
                  cambioGenero: generoCambio,
                  buttonText: buttonText,
                  buttonClick: isButtonDisabled,
                )
              ],
            ),
          ),
        ));
  }
}
