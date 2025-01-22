import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_app_one/personaje.dart';

//import 'package:flutter_app_one/pantalla_personaje.dart';

import 'package:http/http.dart' as http;

class PantallaListaPersonajes extends StatefulWidget {
  const PantallaListaPersonajes({super.key, required String title});

  @override
  State<PantallaListaPersonajes> createState() => _PantallaListaPersonajesState();
}

class _PantallaListaPersonajesState extends State<PantallaListaPersonajes> {
  String textoPersonaje = "";

  @override
  void initState() {
    descargarPersonajes();
    print("entra al void d lista_personajes");
    super.initState();
  }

  /*
    Aquí descargamos los personajes de la API 
  */
  void descargarPersonajes() async {

    print("Entro a descargarPersonaje");

    final url = Uri.parse("https://anapioficeandfire.com/api/characters/583");
    final response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Entro al if de descargarPersonaje");
      final json = response.body;
      print(json);
    
      Personaje personaje = Personaje.fromJson(jsonDecode(json));
      textoPersonaje = " Nombre: ${personaje.nombre} \n\n Género: ${personaje.genero}\n\n Cultura: ${personaje.cultura}\n\n Fecha de nacimiento:  ${personaje.nacido}";
      print(textoPersonaje);
    } else {
      textoPersonaje = "Error al cargar el personaje... ";
    }
    
    setState(() {}); // Actualiza la Interfaz de Usuario
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}