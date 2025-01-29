import 'package:flutter/material.dart';
import 'package:flutter_app_one/ficha_personaje.dart';
import 'package:flutter_app_one/personaje.dart';

class PantallaPersonajesFavoritos extends StatefulWidget {
  const PantallaPersonajesFavoritos({super.key, required String title});

  @override
  State<PantallaPersonajesFavoritos> createState() => _PantallaPersonajesFavoritosState();
}

class _PantallaPersonajesFavoritosState extends State<PantallaPersonajesFavoritos> {
  String textoPersonaje = "";

  // Cambié List<String> a List<Personaje>
  final List<Personaje> arrayPersonajes = [];

  @override
  void initState() {
    print("Entra al initState de personajes favoritos");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: arrayPersonajes.isEmpty
          ? const Center(
              child: Text('No hay personajes en favoritos'),
            )
          : ListView.builder(
              itemCount: arrayPersonajes.length,
              itemBuilder: (context, index) {
                final personajeA = arrayPersonajes[index]; // Ahora es un objeto Personaje
                return ListTile(
                  title: Text(personajeA.nombre), // Se puede acceder a nombre
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
