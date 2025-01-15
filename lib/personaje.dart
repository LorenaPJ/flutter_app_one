class Personaje {
  final String nombre;
  final String genero;
  final String cultura;
  final String nacido;
  final String titulos;

  const Personaje({required this.nombre, required this.genero, required this.cultura, required this.nacido, required this.titulos});

  factory Personaje.fromJson(Map<String, dynamic> json) {
    return Personaje(
        nombre :json['name'] as String, genero :json['gender'] as String, cultura :json['culture'] as String,
         nacido :json['born'] as String, titulos :json['titles'] as String);
    
  }
}