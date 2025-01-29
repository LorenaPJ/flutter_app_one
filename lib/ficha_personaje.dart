import 'package:flutter/material.dart';
import 'package:flutter_app_one/personaje.dart';

class PantallaFichaDelPersonaje extends StatelessWidget {
  final Personaje character;

  const PantallaFichaDelPersonaje({super.key, required this.character}); // Constructor corregido

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información Personaje'),
      ),
     body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
            crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente
            children: [
              Text('Nombre:  ${character.nombre}', style: const TextStyle(fontSize: 20)),
              Text('Género:  ${character.genero}', style: const TextStyle(fontSize: 20)),
              Text('Cultura:  ${character.cultura}', style: const TextStyle(fontSize: 20)),
              Text('Nacido:  ${character.nacido}', style: const TextStyle(fontSize: 20)),
            ],
          ),
        ),
    ));
  }
}
