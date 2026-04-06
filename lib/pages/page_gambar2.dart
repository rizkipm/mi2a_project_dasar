import 'package:flutter/material.dart';

class PageGambar2 extends StatelessWidget {
  const PageGambar2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image From Network"),
        backgroundColor: Colors.brown,
      ),
      
      body: Center(
        child: Image.network("https://media.dekoruma.com/article/2018/09/13100520/Rumah-Gadang-1.jpg?fit=300%2C200&ssl=1"),
      ),
    );
  }
}
