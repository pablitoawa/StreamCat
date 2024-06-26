import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streamcat/screens/Reproductor.dart';

void main() {
  runApp(const Productos());
}

class Productos extends StatelessWidget {
  const Productos({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Lista(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List<Map<dynamic, dynamic>> movieList = [];
  String userName = "";

  @override
  void initState() {
    super.initState();
    getUserName();
    getData();
  }

  void getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref('users/${user.uid}');
      userRef.once().then((DatabaseEvent event) {
        final data = event.snapshot.value as Map?;
        if (data != null && data['nombre'] != null) {
          setState(() {
            userName = data['nombre'];
          });
        }
      });
    }
  }

  void getData() {
    DatabaseReference movieRef = FirebaseDatabase.instance.ref('movies');
    movieRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateMovieList(data);
    });
  }

  void updateMovieList(dynamic data) {
    if (data != null) {
      List<Map<dynamic, dynamic>> tempList = [];
      data.forEach((key, value) {
        tempList.add({
          "title": value['title'],
          "poster": value['poster'],
          "description": value['description'],
          "rating": value['rating'],
          "pelicula": value['pelicula']
        });
      });

      setState(() {
        movieList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Bienvenido de vuelta, $userName",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: movieList.length,
                itemBuilder: (context, index) {
                  return MovieCard(
                    title: movieList[index]["title"],
                    poster: movieList[index]["poster"],
                    description: movieList[index]["description"],
                    rating: movieList[index]["rating"],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YoutubePlayerScreen(videoUrl: movieList[index]["pelicula"]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String poster;
  final String description;
  final String rating;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.title,
    required this.poster,
    required this.description,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
              ),
              child: Image.network(
                poster,
                width: 120,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          rating.toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDetailScreen extends StatelessWidget {
  final String title;
  final String poster;
  final String description;
  final String rating;

  const MovieDetailScreen({
    super.key,
    required this.title,
    required this.poster,
    required this.description,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              poster,
              width: 200,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              description,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Rating: $rating",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
