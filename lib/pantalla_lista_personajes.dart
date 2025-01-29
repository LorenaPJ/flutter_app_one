import 'package:flutter/material.dart';
import 'package:flutter_app_one/ficha_personaje.dart';
//import 'package:flutter_app_one/ficha_personaje.dart';

//import 'package:flutter_app_one/celda.dart';

import 'dart:convert';

import 'package:flutter_app_one/personaje.dart';

//import 'package:flutter_app_one/celda.dart';

//import 'package:flutter_app_one/pantalla_personaje.dart';

import 'package:http/http.dart' as http;


class PantallaListaPersonajes extends StatefulWidget {
  const PantallaListaPersonajes({super.key, required String title});
  
  get personajesFavoritos => null;

  @override
  State<PantallaListaPersonajes> createState() => _PantallaListaPersonajesState();
  
}


class _PantallaListaPersonajesState extends State<PantallaListaPersonajes> {

  String textoPersonaje = "";

  List<Personaje> arrayPersonajes = [];

  final List<Personaje> personajesFavoritos = [];

  bool cargando =true;

/*
  int numeroPagina = 1;
  int numeroPaginas= numeroPagina +1;*/

  @override
  void initState() {
    print("Entra al void d lista_personajes");
    descargarPersonajes();
    super.initState();
  }

  /*
    Aquí descargamos los personajes de la API 
  */
  void descargarPersonajes() async {

    print("Entró a descargar personajes en lista_personajes");

    final url = Uri.parse("https://anapioficeandfire.com/api/characters?page=1&pageSize=50");

    try {
      final response = await http.get(url);

      if (response.statusCode ==200){
        final List<dynamic> data = jsonDecode(response.body);

        setState(() {
          arrayPersonajes = data
            .map((json) => Personaje.fromJson(json))
            .where((arrayPersonajes) => arrayPersonajes.nombre.isNotEmpty)
            .toList();
            cargando = false;
        });
      } else {
          setState(() {
            cargando =false;
          });
        }
    } catch (e){
      setState(() {
            cargando =false;
          });
    }
}
      
  /*
      Agregar favoritos
  */
  void agregarFavoritos(Personaje personaje){
    
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

    print("Entro al build de lista de personajes");
     return Scaffold(
        //Barra encima de todo
        appBar: AppBar(
          title: const Text('Lista de personajes'),
        ),
        body: Center(
          child: ListView.separated(
            itemCount: arrayPersonajes.length,
            separatorBuilder: (context, index) {
              return const Divider(color: Colors.deepPurple);
            },
            itemBuilder: (context, index) {
              final personajeElegido =arrayPersonajes[index];
              return ListTile(
                title: Text(personajeElegido.nombre),
                trailing: IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () => agregarFavoritos(personajeElegido),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallaFichaDelPersonaje(character:personajeElegido),
                      ),
                    );
                  },   
              );
              
              
            }, 
          )
        ),
      );
  }
}
