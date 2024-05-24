import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  final TextEditingController idController;
  final TextEditingController nombreController;
  final TextEditingController apellidoController;
  final TextEditingController correoController;
  final TextEditingController telefonoController;
  final TextEditingController passController;
  final String genero;
  final bool isEditing;
  final Function(BuildContext) onSubmit;
  final Function(String) cambioGenero;

  const UserForm({
    super.key,
    required this.idController,
    required this.nombreController,
    required this.apellidoController,
    required this.correoController,
    required this.telefonoController,
    required this.passController,
    required this.genero,
    required this.onSubmit,
    required this.isEditing,
    required this.cambioGenero,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: idController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Número de documento',
          ),
          keyboardType: TextInputType.number,
          enabled: isEditing ? false : true,
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: apellidoController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Apellido',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Column(
          children: [
            const Text(
              "Género",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                    child: RadioListTile(
                  value: "Masculino",
                  groupValue: genero,
                  title: const Text("Masculino"),
                  onChanged: (value) {
                    cambioGenero(value.toString());
                  },
                )),
                Expanded(
                  child: RadioListTile(
                    value: "Femenino",
                    groupValue: genero,
                    title: const Text(
                      "Femenino",
                    ),
                    onChanged: (value) {
                      cambioGenero(value.toString());
                    },
                  ),
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 30),
        TextField(
          controller: correoController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Correo electrónico',
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 30),
        TextField(
          controller: telefonoController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Teléfono',
          ),
          keyboardType: TextInputType.phone,
        ),
        isEditing
            ? const SizedBox()
            : Column(
                children: [
                  const SizedBox(height: 30),
                  TextField(
                    controller: passController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ],
              ),
        const SizedBox(height: 30),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              onSubmit(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              backgroundColor: Colors.red.shade300,
            ),
            child: Text(
              isEditing ? "Editar Cuenta" : 'Crear Cuenta',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
