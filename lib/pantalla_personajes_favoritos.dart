import 'package:flutter/material.dart';
import 'package:flutter_app_one/ficha_personaje.dart';
import 'package:flutter_app_one/personaje.dart';

class PantallaPersonajesFavoritos extends StatefulWidget {
  final List<Personaje> personajesFavoritos; // Recibe la lista de favoritos

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
              child: Text('No hay personajes en favoritos todavía'),
            )
          : ListView.builder(
              itemCount: widget.personajesFavoritos.length,
              itemBuilder: (context, index) {
                final personajeA = widget.personajesFavoritos[index];
                return ListTile(
                  title: Text(personajeA.nombre),
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

