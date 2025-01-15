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
    super.initState();
  }

  void descargarPersonajes() async {
    final url = Uri.parse("https://anapioficeandfire.com");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = response.body;
      Personaje personaje = Personaje.fromJson(jsonDecode(json));
      textoPersonaje = "${personaje.nombre} \n\n ${personaje.genero}\n\n ${personaje.cultura}\n\n ${personaje.nacido}\n\n ${personaje.titulos}";
    } else {
      textoPersonaje = "Error al cargar el personaje... ";
    }
    setState(() {}); // Actualiza la Interfaz de Usuario
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: textoPersonaje.isEmpty
              ? const CircularProgressIndicator()
              : Text(textoPersonaje,
                  style:
                      const TextStyle(fontSize: 30, color: Colors.deepOrange))),
    );
  }
}