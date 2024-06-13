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
      campoId(),
      campoProducto(),
      campoPrecio(),
      agregar(),
    ],
  ));
}

final TextEditingController _id = TextEditingController();
Widget campoId() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: (TextField(
        controller: _id,
        decoration: const InputDecoration(
            labelText: "ID",
            hintText: "Ingresa el ID",
            hintTextDirection: TextDirection.ltr))),
  );
}

final TextEditingController _producto = TextEditingController();
Widget campoProducto() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: (TextField(
      controller: _producto,
      decoration: const InputDecoration(
        labelText: "Producto",
        hintText: "Ingresa el producto",
        hintTextDirection: TextDirection.ltr,
      ),
    )),
  );
}

final TextEditingController _precio = TextEditingController();
Widget campoPrecio() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: (TextField(
      controller: _precio,
      decoration: const InputDecoration(
        labelText: "Precio",
        hintText: "Ingresa el precio",
        hintTextDirection: TextDirection.ltr,
      ),
    )),
  );
}

Widget agregar() {
  return (FilledButton(onPressed: () {guardar();}, child: const Text("Añadir")));
}

Future<void> guardar() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("producto/123");

  await ref.set({
    "id": _id.text,
    "producto": _producto.text,
    "precio": _precio.text
  });
}
