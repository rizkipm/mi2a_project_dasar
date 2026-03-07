import 'package:flutter/material.dart';

class PageListview extends StatelessWidget {
  const PageListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Page List View"),
      ),

      body: ListView(
        children: [
          Container(
            height: 100,
            color: Colors.red,
          ),
          SizedBox(height: 10,),//spase kalau ke bawah atau vertical
          Container(
            height: 100,
            color: Colors.black,
          ),
          SizedBox(height: 10,),
          Container(
            height: 100,
            color: Colors.blue,
          ),
          SizedBox(height: 10,),
          Container(
            height: 100,
            color: Colors.green,
          ),
          Container(
            height: 100,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}
