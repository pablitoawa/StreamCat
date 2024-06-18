import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streamcat/screens/ProductosScreen.dart';

void main() {
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
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
                  'StreamCat',
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
                  "Bienvenido de nuevo!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
                campoCorreo(_correoController),
                const SizedBox(height: 16.0),
                campoClave(_contraseniaController),
                const SizedBox(height: 24.0),
                botonInicio(context),
              ],
            ),
          ),
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
        hintText: 'Ingresa tu usuario o e-mail',
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
        hintText: 'Ingresa tu contraseña',
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

  Widget botonInicio(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          login(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: const Text(
          'Ingresar',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _correoController.text,
        password: _contraseniaController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Productos()),
      );
    } on FirebaseAuthException catch (e) {
      mostrarAlertError(e.code, context);
    }
  }

  void mostrarAlertError(String codigo, BuildContext context) {
    String mensaje = '';
    switch (codigo) {
      case 'user-not-found':
        mensaje = 'No existe un usuario con ese correo.';
        break;
      case 'wrong-password':
        mensaje = 'Contraseña incorrecta.';
        break;
      default:
        mensaje = 'Error en las credenciales.';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error de inicio de sesión'),
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
