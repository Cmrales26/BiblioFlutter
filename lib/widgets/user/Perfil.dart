// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reserva_libros/components/AppAdminBar.dart';
import 'package:reserva_libros/components/AppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});
  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  void initState() {
    super.initState();
    GetUser();
  }

  String id = "a";
  String nombre = "a";
  String apellido = "a";
  String genero = "a";
  String correo = "a";
  String telefono = "a";
  String rol = "a";

  Future<void> GetUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId = prefs.getString('userId');
    String? UserNombre = prefs.getString("userNombre");
    String? UserApellido = prefs.getString("userApellido");
    String? UserGenero = prefs.getString("userGenero");
    String? UserCorreo = prefs.getString("userCorreo");
    String? UserTelefono = prefs.getString("userTelefono");
    String? UserRol = prefs.getString("rol");

    if (UserId != null &&
        UserNombre != null &&
        UserApellido != null &&
        UserGenero != null &&
        UserCorreo != null &&
        UserTelefono != null &&
        UserRol != null) {
      setState(() {
        id = UserId;
        nombre = UserNombre;
        apellido = UserApellido;
        genero = UserGenero;
        correo = UserCorreo;
        telefono = UserTelefono;
        rol = UserRol;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? bottomNavBar;

    if (rol == "usuario") {
      bottomNavBar = const CustomBottomAppBar();
    } else if (rol == "admin") {
      bottomNavBar = const AdminBar();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.red,
              child: Text(
                nombre[0] + apellido[0],
                style: const TextStyle(fontSize: 40),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: rol != "admin" ? 40 : 0),
                  child: Row(
                    children: [
                      Text(
                        nombre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(" "),
                      Text(
                        apellido,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                rol != "usuario"
                    ? const SizedBox()
                    : IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pushNamed(context, '/editarCuenta');
                        },
                      ),
              ],
            ),
            Center(
              child: Text(
                id,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Row(
                  children: [
                    Icon(Icons.person, color: Colors.red),
                    SizedBox(width: 10.0),
                    Text(
                      "Género:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: Text(
                    genero,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.email, color: Colors.red),
                    SizedBox(width: 10.0),
                    Text(
                      "Correo:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: Text(
                    correo,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.phone, color: Colors.red),
                    SizedBox(width: 10.0),
                    Text(
                      "Teléfono:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: Text(
                    telefono,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.work, color: Colors.red),
                    SizedBox(width: 10.0),
                    Text(
                      "Rol:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: Text(
                    rol,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              height: 1.0,
              color: Colors.grey,
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Row(
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 10.0),
                  Text(
                    "Cerrar sesión",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar,
    );
  }
}
