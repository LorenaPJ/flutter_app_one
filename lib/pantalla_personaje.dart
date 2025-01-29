import 'dart:convert';

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_app_one/pantalla_lista_personajes.dart';

import 'package:flutter_app_one/pantalla_personajes_favoritos.dart';

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

  /*
    Randomizamos los personajes para mostrar uno nuevo en la pantalla d inicio cada vez q se refresca la página.
  */
  int randomNumber(){
     int numero = Random().nextInt(2135);
   
    return numero;
  }
  
  /*
      Aquí descargamos los personajes de la API 
  */
    void descargarPersonajes() async {

      print("Entro a descargarPersonaje");

      final url = Uri.parse("https://anapioficeandfire.com/api/characters/${randomNumber()}");
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Entro al if de descargarPersonaje");
        final json = response.body;
        //print(json);
      
        Personaje personaje = Personaje.fromJson(jsonDecode(json));
        textoPersonaje = " Nombre: ${personaje.nombre} \n Género: ${personaje.genero}\n Cultura: ${personaje.cultura}\n Fecha de nacimiento:  ${personaje.nacido}";
        print(textoPersonaje);
      } else {
        textoPersonaje = "Error al cargar el personaje... ";
      }
      
      setState(() {}); // Actualiza la Interfaz de Usuario
    }

  /*
    Navigator que nos lleva a la pantalla de Lista de Personajes.
  */
    void mostrarListaPersonajes() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) =>  PantallaListaPersonajes(title: 'AAAAA',)));
    }

    /*
    Navigator que nos lleva a la pantalla en la que tenemos nuestra lISTA DE personajes Favoritos.
  */
    void mostrarListaFavoritos() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const PantallaPersonajesFavoritos(title: '',)));
    }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Personajes de Juegos de tronos'),
          backgroundColor: const Color.fromARGB(255, 173, 124, 217),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Alinea horizontalmente los widgets
          mainAxisAlignment: MainAxisAlignment.start,   // Controla la alineación vertical
          children: [
            const Center(
              child: Text(
                "Personajes de Juego de Tronos",
                style: TextStyle(
                  fontSize: 45,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: textoPersonaje.isEmpty
                  ? const CircularProgressIndicator()
                  : Text(
                      textoPersonaje,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 173, 43, 147),
                      ),
                    ),
            ),
            ElevatedButton(onPressed: (){
              print("Boton de lista de personajes presionado");
              mostrarListaPersonajes();

            }, child: const Text("Lista de Personajes")),
            const Padding(padding: EdgeInsets.all(20)),
            
            ElevatedButton(onPressed: (){
              print("Boton de lista de personajes favoritos presionado");
              mostrarListaFavoritos();
            }, child: const Text("Lista de Favoritos"))
          ],
        ),
    );
  }
}