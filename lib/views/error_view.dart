import 'package:fl_menu/models/models.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ErrorModel error =
        ModalRoute.of(context)?.settings.arguments as ErrorModel;

    DateTime date = error.date;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Informe de error",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                "Fecha: ${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}:${date.second}",
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              const Text("Servicio origen:"),
              Text(error.url ?? "No definido"),
              const SizedBox(height: 10),
              const Text("DB Origen:"),
              Text(error.storeProcedure ?? "No Aplica."),
              const SizedBox(height: 10),
              const Text("Descripcion:"),
              Text(error.description),
            ],
          ),
        ),
      ),
    );
  }
}
