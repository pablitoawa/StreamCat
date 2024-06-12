import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:streamcat/screens/LoginScreen.dart';
import 'package:streamcat/screens/RegisterScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const Main());
}


class Main extends StatelessWidget {
  const Main({super.key});

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
        title: const Text('Flutter'),
      ),
      body: Cuerpo(context),
    );
  }

}

Widget cuerpo(context) {
  return Container(
    padding: const EdgeInsets.all(20),
    alignment: Alignment.center,
    child: (Column(
      children: <Widget>[
        const Text("Welcome"),
        botonLogin(context),
        botonRegistro(context),
      ],
    )),
  );
}

Widget botonLogin(context) {
  return (FilledButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
      },
      child: const Text("Iniciar sesion")));
}

Widget botonRegistro(context) {
  return (ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Registro()));
      },
      child: const Text("Registrate")));
}


