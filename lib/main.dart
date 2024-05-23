import 'package:flutter/material.dart';
import 'package:reserva_libros/widgets/admin/Dashboard.dart';
import 'package:reserva_libros/widgets/admin/LoginAdmin.dart';
import 'package:reserva_libros/widgets/user/Crear.dart';
import 'package:reserva_libros/widgets/user/Editar.dart';
import 'package:reserva_libros/widgets/user/Inicio.dart';
import 'package:reserva_libros/widgets/user/Login.dart';
import 'package:reserva_libros/widgets/user/Perfil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const UserLogin(),
        '/home': (context) => const Inicio(),
        '/perfil': (context) => const Perfil(),
        '/crearCuenta': (context) => const Crear(),
        '/editarCuenta': (context) => const EditUser(),
        // ADMIN
        '/loginAdmin': (context) => const AdminLogin(),
        '/dashboard': (context) => const Dashboard()
      },
    );
  }
}
