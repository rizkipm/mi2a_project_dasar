import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mi2a_project_dasar/models/movie.dart';
import 'package:mi2a_project_dasar/pages/page_detail_movie.dart';


class PageHomeMovie extends StatefulWidget {
  const PageHomeMovie({super.key});

  @override
  State<PageHomeMovie> createState() => _PageHomeMovieState();
}

class _PageHomeMovieState extends State<PageHomeMovie> {

  List<Movie> movies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //proses do in background sebelum view di panggil
    loadMovies();
  }

  Future<void> loadMovies() async{
    final String response = await rootBundle.loadString("lib/data/movies.json");//pastikan udah d masukkan di puspec.yml
    final data = json.decode(response);

    setState(() {
      movies = List<Movie>.from(
        data.map((item) => Movie.fromJson(item))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie App"),
        backgroundColor: Colors.redAccent,
      ),
       body: ListView.builder(
         itemCount: movies.length,
         itemBuilder: (context,index){
           final movie = movies[index];

           return ListTile(
             leading: Image.asset(movie.image, width: 50,),
             title: Text(movie.title),
             onTap: (){
               //panggil page detail
               Navigator.push(context, MaterialPageRoute(builder: (_)=>
                PageDetailMovie(movie: movie)
               ));
             },
           );
         },
       ),
    );
  }
}
