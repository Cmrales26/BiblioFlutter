// ignore_for_file: file_names, use_build_context_synchronously
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:reserva_libros/ruta.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  void initState() {
    super.initState();
    getPreferencias();
  }

  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();
  String error = '';
  bool isError = false;
  String nombre = '';
  Future login(context) async {
    final res =
        await http.post(Uri.parse("${Ruta.ruta}/admin/loginAdmin.php"), body: {
      'id': id.text,
      'contraseña': password.text,
    });

    final statusCode = res.statusCode;
    final items = json.decode(res.body);
    if (statusCode == 200) {
      final user = items['user'][0];
      final userId = user["id"];
      final userNombre = user["nombre"];
      final userApellido = user["apellido"];
      final userGenero = user["genero"];
      final userCorreo = user["correo"];
      final userTelefono = user["telefono"];
      final rol = user["rol"];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId);
      await prefs.setString('userNombre', userNombre);
      await prefs.setString('userApellido', userApellido);
      await prefs.setString('userGenero', userGenero);
      await prefs.setString('userCorreo', userCorreo);
      await prefs.setString('userTelefono', userTelefono);
      await prefs.setString('rol', rol);

      Navigator.pushReplacementNamed(context, "/dashboard");
    } else {
      setState(() {
        isError = true;
        error = items['respuesta'];
      });
    }
  }

  String preferid = "";
  String preferRol = "";

  Future<void> getPreferencias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    String? userRol = prefs.getString("rol");

    if (userId != null && userRol != null) {
      setState(() {
        preferid = userId;
        preferRol = userRol;
      });

      if (preferRol == "usuario") {
        Navigator.pushReplacementNamed(context, "/home");
      } else if (preferRol == "admin") {
        Navigator.pushReplacementNamed(context, "/dashboard");
      }
    } else {
      preferid = "";
      preferRol = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'Biblioteca Admin',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Ingrese su ID y Contraseña',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w100,
              ),
            ),
            isError
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 20),
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
                : const SizedBox(height: 20),
            Text(nombre),
            TextField(
              controller: id,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ID',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Contraseña',
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  login(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  backgroundColor: Colors.blue.shade300,
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/");
                },
                child: const Text(
                  "Iniciar Como Usuario",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
