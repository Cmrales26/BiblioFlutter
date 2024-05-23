import 'package:flutter/material.dart';
import 'package:reserva_libros/components/AppAdminBar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      // body: ,
      bottomNavigationBar: const AdminBar(),
    );
  }
}