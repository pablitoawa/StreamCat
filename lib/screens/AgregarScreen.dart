import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Agregar());
}

class Agregar extends StatelessWidget {
  const Agregar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar'),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(76, 62, 123, 0.35),
              Color.fromRGBO(146, 70, 127, 0.35),
            ],
          )),
          child: cuerpo(),
        ),
      ),
    );
  }
}

Widget cuerpo() {
  return (Column(
    children: <Widget>[
      const Text("Añade el producto"),
      campoTitle(),
      campoPoster(),
      campoDescripcion(),
      campoRating(),
      agregar(),
    ],
  ));
}

final TextEditingController _title = TextEditingController();
Widget campoTitle() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: (TextField(
        controller: _title,
        decoration: const InputDecoration(
            labelText: "Title",
            hintText: "Ingresa el Titulo de la pelicula",
            hintTextDirection: TextDirection.ltr))),
  );
}

final TextEditingController _imagen = TextEditingController();
Widget campoPoster() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: (TextField(
      controller: _imagen,
      decoration: const InputDecoration(
        labelText: "Imagen",
        hintText: "Link",
        hintTextDirection: TextDirection.ltr,
      ),
    )),
  );
}

final TextEditingController _descripcion = TextEditingController();
Widget campoDescripcion() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: (TextField(
      controller: _descripcion,
      decoration: const InputDecoration(
        labelText: "Descripcion",
        hintText: "Ingresa la descripcion",
        hintTextDirection: TextDirection.ltr,
      ),
    )),
  );
}

final TextEditingController _rating = TextEditingController();
Widget campoRating() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: (TextField(
      controller: _rating,
      decoration: const InputDecoration(
        labelText: "Rating",
        hintText: "Ingrese el Rating",
        hintTextDirection: TextDirection.ltr,
      ),
    )),
  );
}

Widget agregar() {
  return (FilledButton(onPressed: () {guardar();}, child: const Text("Añadir")));
}

Future<void> guardar() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("movies/"+_title.text);

  await ref.set({
    "title": _title.text,
    "poster": _imagen.text,
    "description": _descripcion.text,
    "rating": _rating.text
  });
}
