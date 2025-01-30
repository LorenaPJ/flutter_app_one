import 'package:flutter/material.dart';

import 'package:flutter_app_one/ficha_personaje.dart';

import 'package:flutter_app_one/personaje.dart';

class PantallaPersonajesFavoritos extends StatefulWidget {
  final List<Personaje> personajesFavoritos;

  const PantallaPersonajesFavoritos({super.key, required this.personajesFavoritos, required String title});

  @override
  State<PantallaPersonajesFavoritos> createState() => _PantallaPersonajesFavoritosState();
}

class _PantallaPersonajesFavoritosState extends State<PantallaPersonajesFavoritos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: widget.personajesFavoritos.isEmpty
          ? const Center(
              child: Text('No hay personajes en favoritos'),
            )
          : ListView.builder(
              itemCount: widget.personajesFavoritos.length,
              itemBuilder: (context, index) {
                final personajeA = widget.personajesFavoritos[index]; // Ahora es un objeto Personaje
                return ListTile(
                  title: Text(personajeA.nombre), // Accede a nombre
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallaFichaDelPersonaje(character: personajeA),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
