import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streamcat/screens/LoginScreen.dart';
import 'package:streamcat/screens/RegisterScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Main());
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
      body: SafeArea(
        child: Container(
          color: const Color.fromRGBO(0, 0, 68, 0.8),
          child: cuerpo(context),
        ),
      ),
    );
  }
}

Widget cuerpo(context) {
  return Container(
    padding: const EdgeInsets.all(20),
    alignment: Alignment.center,
    child: Column(
      children: <Widget>[
        imagen(),
        nameapp(),
        slogan(),
        const Spacer(), // Esto empuja el botón de inicio de sesión hacia abajo
        botonLogin(context),
        const SizedBox(height: 10), // Espacio entre los botones
        registroTexto(context),
      ],
    ),
  );
}

Widget imagen() {
  return const ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    child: Image(image: AssetImage("assets/image/gato.png")),
  );
}

Widget slogan() {
  return Container(
    margin: const EdgeInsets.only(top: 25),
    child: Text(
      "Descubre, explora, disfruta",
      textAlign: TextAlign.center,
      style: GoogleFonts.satisfy(
        textStyle: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          color: Colors.amber,
        ),
      ),
    ),
  );
}

Widget nameapp() {
  return Text(
    "StreamCat",
    textAlign: TextAlign.center,
    style: GoogleFonts.satisfy(
      textStyle: const TextStyle(
        fontSize: 52,
        fontWeight: FontWeight.w700,
        color: Colors.amber,
      ),
    ),
  );
}

Widget botonLogin(context) {
  return Row(
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
          },
          child: const Text("Iniciar sesión"),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: const Color.fromRGBO(254, 243, 186, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    ],
  );
}

Widget registroTexto(context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Registro()));
    },
    child: const Text(
      "¿No tienes cuenta? Regístrate",
      style: TextStyle(
        color: Colors.amber,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    ),
  );
}
