//import 'dart:convert';

import 'package:flutter/material.dart';

//import 'package:flutter_app_one/personaje.dart';

//import 'package:flutter_app_one/personaje.dart';

//import 'package:http/http.dart' as http;

class PantallaPersonajesFavoritos extends StatefulWidget {
  const PantallaPersonajesFavoritos({super.key, required String title});

  @override
  State<PantallaPersonajesFavoritos> createState() => _PantallaPersonajesFavoritosState();
}

class _PantallaPersonajesFavoritosState extends State<PantallaPersonajesFavoritos>{
  String textoPersonaje = "";

  @override
    void initState() {
      
      print("entra al void d personajes favoritos");
      super.initState();
    }
    
      @override
      Widget build(BuildContext context) {
    // TODO: implement build
    print("Pantalla personajes Favoritos");
    throw UnimplementedError();
      }
}