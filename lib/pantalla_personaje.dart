import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_app_one/personaje.dart';

import 'package:http/http.dart' as http;

class PantallaPersonaje extends StatefulWidget {
  const PantallaPersonaje({super.key, required String title});

  @override
  State<PantallaPersonaje> createState() => _PantallaPersonajeState();
}

class _PantallaPersonajeState extends State<PantallaPersonaje> {
  String textoPersonaje = "";

  @override
  void initState() {
    descargarPersonajes();
    print("entra al void d pantalla_personaje");
    super.initState();
  }

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
      textoPersonaje = "${personaje.nombre} \n\n ${personaje.genero}\n\n ${personaje.cultura}\n\n ${personaje.nacido}";
      print(textoPersonaje);
    } else {
      textoPersonaje = "Error al cargar el personaje... ";
    }
    
    setState(() {}); // Actualiza la Interfaz de Usuario
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children:[ 
              Text(textoPersonaje,
              style: const TextStyle(fontSize: 30, color: Colors.deepOrange)),
          ]
      ),
    );
  }
}