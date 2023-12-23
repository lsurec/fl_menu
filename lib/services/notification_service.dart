// ignore_for_file: use_build_context_synchronously

import 'package:fl_menu/models/models.dart';
import 'package:fl_menu/views/error_view.dart';
import 'package:fl_menu/widgets/alert_widget.dart';
import 'package:flutter/material.dart';

class NotificationService {
  //Key dcaffkod global
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  //Mostrar snack bar
  static showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      // action: SnackBarAction(
      //   label: 'Aceptar',
      //   onPressed: () => Navigator.pop(context),
      // ),
    );

    //mosttar snack
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static Future<void> showErrorView(
    BuildContext context,
    ErrorModel error,
  ) async {
    bool result = await showDialog(
          context: context,
          builder: (context) => AlertWidget(
            title: "Algo salió mal",
            description:
                "No se pudo completar el proceso de conexión al servicio. Por favor, inténtalo de nuevo más tarde.",
            onOk: () => Navigator.of(context).pop(true),
            onCancel: () => Navigator.of(context).pop(false),
            textCancel: "Ver informe",
            textOk: "Aceptar",
          ),
        ) ??
        true;

    //Si quiere verse el error
    if (!result) {
      //navegar a pantalla para ver el error
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ErrorView(),
          settings: RouteSettings(
            arguments: error,
          ),
        ),
      );
    }
  }
}
