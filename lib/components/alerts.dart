// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class SuccessAlert extends StatelessWidget {
  final String title;
  final String redirectRoute;

  const SuccessAlert({key, required this.title, required this.redirectRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, redirectRoute, (route) => false);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
