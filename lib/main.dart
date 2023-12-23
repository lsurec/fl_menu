import 'package:fl_menu/view_models/menu_view_model.dart';
import 'package:fl_menu/views/menu_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuViewModel()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: MenuView(),
    );
  }
}
