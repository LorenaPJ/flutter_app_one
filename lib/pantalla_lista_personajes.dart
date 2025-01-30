import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_app_one/ficha_personaje.dart';
import 'package:flutter_app_one/personaje.dart';
import 'package:flutter_app_one/pantalla_personajes_favoritos.dart';
import 'package:flutter_app_one/variables_globales.dart';
import 'package:http/http.dart' as http;

class PantallaListaPersonajes extends StatefulWidget {
  const PantallaListaPersonajes({super.key, required String title});

  @override
  State<PantallaListaPersonajes> createState() => _PantallaListaPersonajesState();
}

class _PantallaListaPersonajesState extends State<PantallaListaPersonajes> {

  List<Personaje> arrayPersonajes = []; //Array vacio para llenarlo con personajes.

  bool cargando = true;

  @override
  void initState() {
    super.initState();
    descargarPersonajes();
  }

  /*
   Función para descargar personajes de la API.
   */
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

  /*
   Función para agregar a favoritos.
   */
  void agregarFavoritos(Personaje personaje) {
    if (!variablesGlobales.personajesFavoritos.contains(personaje)) {
      setState(() {
        variablesGlobales.personajesFavoritos.add(personaje);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${personaje.nombre} añadido a favoritos <3')),
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
            onPressed: () async {
              // Navegar a favoritos y esperar el resultado
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PantallaPersonajesFavoritos(title: 'pepito',),
                ),
              );

              // Si la lista de favoritos cambia, actualiza la lista
              if (result != null && result is List<Personaje>) {
                setState(() {
                  variablesGlobales.personajesFavoritos = result;
                });
              }
            },
          ),
        ],
      ),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: arrayPersonajes.length,
              separatorBuilder: (context, index) => const Divider(color: Colors.deepPurple),
              itemBuilder: (context, index) {
                final personajeElegido = arrayPersonajes[index];
                final esFavorito = variablesGlobales.personajesFavoritos.contains(personajeElegido);
                return ListTile(
                  title: Text(personajeElegido.nombre),
                  trailing: IconButton(
                    icon: Icon(esFavorito ? Icons.favorite : Icons.favorite_border, color: esFavorito ? Colors.red : null),
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
    );
  }
}