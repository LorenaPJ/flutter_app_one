import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_app_one/ficha_personaje.dart';
import 'package:flutter_app_one/personaje.dart';
import 'package:flutter_app_one/pantalla_personajes_favoritos.dart';
import 'package:http/http.dart' as http;

class PantallaListaPersonajes extends StatefulWidget {
 PantallaListaPersonajes({super.key, required String title});
  
  // Cambié 'personajesFavoritos' a ser una propiedad en este widget
  final List<Personaje> personajesFavoritos = [];

  @override
  State<PantallaListaPersonajes> createState() => _PantallaListaPersonajesState();
}

class _PantallaListaPersonajesState extends State<PantallaListaPersonajes> {

  List<Personaje> arrayPersonajes = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    descargarPersonajes();
  }

  // Descargar personajes de la API
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

  // Agregar personaje a favoritos
  void agregarFavoritos(Personaje personaje) {
    if (!widget.personajesFavoritos.contains(personaje)) {
      setState(() {
        widget.personajesFavoritos.add(personaje);
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
      ),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: arrayPersonajes.length,
              separatorBuilder: (context, index) {
                return const Divider(color: Colors.deepPurple);
              },
              itemBuilder: (context, index) {
                final personajeElegido = arrayPersonajes[index];
                final esFavorito = widget.personajesFavoritos.contains(personajeElegido);

                return ListTile(
                  title: Text(personajeElegido.nombre),
                  trailing: IconButton(
                    icon: Icon(
                      esFavorito ? Icons.favorite : Icons.favorite_border,
                      color: esFavorito ? Colors.red : null,
                    ),
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
