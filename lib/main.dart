import 'package:flutter/material.dart';
import 'package:streamcat/screens/LoginScreen.dart';
import 'package:streamcat/screens/RegisterScreen.dart';

void main(){
  runApp(Principal());
}

class Principal extends StatelessWidget {
  const Principal({super.key});
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenidos',
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
  int indice=0;
  @override
  Widget build(BuildContext context) {
    List <Widget> screens = [Cuerpo(context), Login(),Registro()];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
<<<<<<< Updated upstream
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
=======
      body: screens[indice],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indice,
        onTap:(valor){
          setState(() {
            indice=valor;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center),label: 'Iniciar Sesion'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center),label: 'Registro')
        ],
>>>>>>> Stashed changes
      ),
    );
  }
}
<<<<<<< Updated upstream
=======

Widget Cuerpo(context) {
  return 
  Center(
    child: Column(
      
      children: <Widget>[
        Titulo(),
      ],
    ),
  );
}

Widget Titulo() {
  return Text("Pagina Principal");
}
>>>>>>> Stashed changes
