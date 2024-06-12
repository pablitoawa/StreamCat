import 'package:flutter/material.dart';
import 'package:streamcat/screens/LoginScreen.dart';

void main() {
  runApp(const Registro());
}

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
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
        title: const Text('Registro'),
      ),
      body: cuerpo(context),
    );
  }
}

Widget cuerpo(context) {
  return (Column(
    children: <Widget>[
      const Text("Bienvenido!! Ingresa tu información para crear una cuenta"),
      campoNombres(),
      campoCorreo(),
      campoClave(),
      botonRegistro(context),
    ],
  ));
}

final TextEditingController _nombres = TextEditingController();
Widget campoNombres() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        const Text("Nombre y Apellido:"),
        (TextField(
          controller: _nombres,
          decoration:
              const InputDecoration(hintText: "Ingresa tu nombre y apellido"),
        )),
      ],
    ),
  );
}

final TextEditingController _correo = TextEditingController();
Widget campoCorreo() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: (TextField(
      controller: _correo,
      decoration: const InputDecoration(hintText: "Ingresa tu e-mail"),
      keyboardType: TextInputType.emailAddress,
    )),
  );
}

final TextEditingController _contrasenia = TextEditingController();
Widget campoClave() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: (TextField(
      controller: _contrasenia,
      decoration: const InputDecoration(hintText: "Ingresa tu contraseña"),
    )),
  );
}

Widget botonRegistro(context) {
  return (FilledButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
      },
      child: const Text("Registrarse")));
}
