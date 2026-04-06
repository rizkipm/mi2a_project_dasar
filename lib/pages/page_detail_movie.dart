import 'package:flutter/material.dart';
import 'package:mi2a_project_dasar/models/movie.dart';

class PageDetailMovie extends StatelessWidget {


  final Movie movie;
  const PageDetailMovie({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: Colors.redAccent,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(movie.image),
          SizedBox(height: 10,),
          Padding(padding: EdgeInsets.all(16.0),
            child: Text(
              movie.desc,
              style:  TextStyle(fontSize: 14),
            ),
          )

        ],
      ),
    );
  }
}
