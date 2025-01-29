import 'package:flutter/material.dart';
import 'package:flutter_app_one/ficha_personaje.dart';
import 'dart:convert';
import 'package:flutter_app_one/personaje.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_one/pantalla_personajes_favoritos.dart';

class PantallaListaPersonajes extends StatefulWidget {
  const PantallaListaPersonajes({super.key, required String title});

  @override
  State<PantallaListaPersonajes> createState() => _PantallaListaPersonajesState();
}

class _PantallaListaPersonajesState extends State<PantallaListaPersonajes> {
  List<Personaje> arrayPersonajes = [];
  final List<Personaje> personajesFavoritos = []; // Lista de favoritos

  bool cargando = true;

  @override
  void initState() {
    super.initState();
    descargarPersonajes();
  }

  void descargarPersonajes() async {
    final url = Uri.parse("https://anapioficeandfire.com/api/characters?page=1&pageSize=50");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          arrayPersonajes = data
              .map((json) => Personaje.fromJson(json))
              .where((personaje) => personaje.nombre.isNotEmpty)
              .toList();
          cargando = false;
        });
      } else {
        setState(() {
          cargando = false;
        });
      }
    } catch (e) {
      setState(() {
        cargando = false;
      });
    }
  }

  void agregarFavoritos(Personaje personaje) {
    if (!personajesFavoritos.contains(personaje)) {
      setState(() {
        personajesFavoritos.add(personaje);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${personaje.nombre} añadido a favoritos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de personajes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Navegar a la pantalla de favoritos pasando la lista
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PantallaPersonajesFavoritos(personajesFavoritos: personajesFavoritos, title: '',),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ListView.separated(
          itemCount: arrayPersonajes.length,
          separatorBuilder: (context, index) {
            return const Divider(color: Colors.deepPurple);
          },
          itemBuilder: (context, index) {
            final personajeElegido = arrayPersonajes[index];
            return ListTile(
              title: Text(personajeElegido.nombre),
              trailing: IconButton(
                icon: Icon(personajesFavoritos.contains(personajeElegido)
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () => agregarFavoritos(personajeElegido),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaFichaDelPersonaje(character: personajeElegido),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

