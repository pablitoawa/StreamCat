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
      body: Cuerpo(),
    );
  }
}

Widget Cuerpo() {
  return (Column(
    children: <Widget>[
      Text("Welcome"),
      CampoCorreo(),
      CampoClave(),
      BotonInicio(),
    ],
  ));
}

final TextEditingController _correo = TextEditingController();
Widget CampoCorreo() {
  return Container(
    padding: EdgeInsets.all(20),
    child: (TextField(
      controller: _correo,
      decoration: InputDecoration(hintText: "Ingresa tu usuario o e-mail"),
      keyboardType: TextInputType.emailAddress,
    )),
  );
}

final TextEditingController _contrasenia = TextEditingController();
Widget CampoClave() {
  return Container(
    padding: EdgeInsets.all(20),
    child: (TextField(
      controller: _contrasenia,
      decoration: InputDecoration(hintText: "Ingresa tu contraseña"),
    )),
  );
}
Widget BotonInicio() {
  return (FilledButton(
      onPressed: () {
        
      },
      child: Text("Ingresar")));
}

