import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Productos());
}

class Productos extends StatelessWidget {
  const Productos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Lista(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Lista extends StatefulWidget {
  const Lista({Key? key}) : super(key: key);

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List<Map<dynamic, dynamic>> productList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    DatabaseReference productoRef = FirebaseDatabase.instance.ref('producto');
    productoRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateProductList(data);
    });
  }

  void updateProductList(dynamic data) {
    if (data != null) {
      List<Map<dynamic, dynamic>> tempList = [];
      data.forEach((key, value) {
        tempList
            .add({"producto": value['producto'], "precio": value['precio']});
      });

      setState(() {
        productList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase ListView'),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${productList[index]["producto"]}'),
          );
        },
      ),
    );
  }
}
