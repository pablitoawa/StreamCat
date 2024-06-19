import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streamcat/screens/LoginScreen.dart';

void main() {
  runApp(const Registro());
}

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
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
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contraseniaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF003366),
              Color(0xFF000033),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Registro',
                  style: GoogleFonts.satisfy(
                    textStyle: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Bienvenido! Ingresa tu información para crear una cuenta",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
                campoNombres(_nombresController),
                const SizedBox(height: 16.0),
                campoCorreo(_correoController),
                const SizedBox(height: 16.0),
                campoClave(_contraseniaController),
                const SizedBox(height: 24.0),
                botonRegistro(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget campoNombres(TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        labelText: 'Nombre y Apellido',
        labelStyle: TextStyle(color: Colors.white),
        hintText: "Ingresa tu nombre",
        hintStyle: TextStyle(color: Colors.white54),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
      ),
    );
  }

  Widget campoCorreo(TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.white),
        hintText: "Ingresa tu e-mail",
        hintStyle: TextStyle(color: Colors.white54),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget campoClave(TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: true,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        labelText: 'Contraseña',
        labelStyle: TextStyle(color: Colors.white),
        hintText: "Ingresa tu contraseña",
        hintStyle: TextStyle(color: Colors.white54),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
      ),
    );
  }

  Widget botonRegistro(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          register(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: const Text(
          'Registrarse',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> register(BuildContext context) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _correoController.text, 
      password: _contraseniaController.text
    );
    await guardar(credential.user!.uid);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
  } on FirebaseAuthException catch (e) {
    mostrarAlertError(e.code, context);
  } catch (e) {
    print(e);
  }
}

  Future<void> guardar(String uid) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/" + uid);

  await ref.set({
    "nombre": _nombresController.text,
    "correo": _correoController.text
  });
}

  void mostrarAlertError(String codigo, BuildContext context) {
    String mensaje = '';
    switch (codigo) {
      case 'weak-password':
        mensaje = 'La contraseña es demasiado débil.';
        break;
      case 'email-already-in-use':
        mensaje = 'El correo electrónico ya está en uso.';
        break;
      default:
        mensaje = 'Error desconocido.';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error de registro'),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
