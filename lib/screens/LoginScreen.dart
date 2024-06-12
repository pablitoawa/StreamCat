import 'package:flutter/material.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

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
        title: const Text('Login'),
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
              )
            ),
            child: cuerpo(),
          ),
        ),
    );
  }
}

Widget cuerpo() {
  return (Column(
    children: <Widget>[
      const Text("Welcome"),
      campoCorreo(),
      campoClave(),
      botonInicio(),
    ],
  ));
}

final TextEditingController _correo = TextEditingController();
Widget campoCorreo() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: (TextField(
      controller: _correo,
      decoration: const InputDecoration(
          labelText: "Email",
          hintText: "Ingresa tu usuario o e-mail",
          hintTextDirection: TextDirection.ltr),
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
      obscureText: true,
      decoration: const InputDecoration(
        labelText: "Contraseña",
        hintText: "Ingresa tu contraseña",
        hintTextDirection: TextDirection.ltr,
      ),
    )),
  );
}

Widget botonInicio() {
  return (FilledButton(onPressed: () {}, child: const Text("Ingresar")));
}
