import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:streamcat/screens/LoginScreen.dart';
import 'package:streamcat/screens/RegisterScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}


class Main extends StatelessWidget {
  const Main({super.key});

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
        title: const Text('Flutter'),
      ),
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(context) {
  return Container(
    padding: EdgeInsets.all(20),
    alignment: Alignment.center,
    child: (Column(
      children: <Widget>[
        Text("Welcome"),
        BotonLogin(context),
        BotonRegistro(context),
      ],
    )),
  );
}

Widget BotonLogin(context) {
  return (FilledButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      },
      child: Text("Iniciar sesion")));
}

Widget BotonRegistro(context) {
  return (ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Registro()));
      },
      child: Text("Registrate")));
}