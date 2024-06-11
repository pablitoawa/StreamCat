import 'package:flutter/material.dart';
import 'package:streamcat/screens/LoginScreen.dart';

void main() {
  runApp(Registro());
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
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(context){
  return(
    Column(
      children: <Widget>[
        Text("Bienvenido!! Ingresa tu información para crear una cuenta"),
        CampoNombres(),
        CampoCorreo(),
        CampoClave(),
        BotonRegistro(context),
      ],
    )
  );
}

final TextEditingController _nombres = TextEditingController();
Widget CampoNombres() {
  return Container(
    padding: EdgeInsets.all(20),
    child: Column(
      children: [
        Text("Nombre y Apellido:"),
        (TextField(
          controller: _nombres,
          decoration: InputDecoration(hintText: "Ingresa tu nombre y apellido"),
        )),
      ],
    ),
  );
}

final TextEditingController _correo = TextEditingController();
Widget CampoCorreo() {
  return Container(
    padding: EdgeInsets.all(20),
    child: (TextField(
      controller: _correo,
      decoration: InputDecoration(hintText: "Ingresa tu e-mail"),
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
Widget BotonRegistro(context){
  return(
   FilledButton(onPressed: (){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Login()));
   }, 
   child: Text("Registrarse")
   )
  );
}