import 'package:flutter/material.dart';
import 'package:flutter_app_one/pantalla_personaje.dart';

void main() {
  runApp(const Aplicacion());

  print("Entro al Main");
}

class Aplicacion extends StatelessWidget {

  const Aplicacion({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game of Thrones',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 185, 49, 126)),
        useMaterial3: true,
      ),
      home: const PantallaPersonaje(title: "Personajes"),
    );
  }
}