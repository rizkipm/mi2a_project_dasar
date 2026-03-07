import 'package:flutter/material.dart';

class PageStack extends StatelessWidget {
  const PageStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Page Stack"),
      ),

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.blue,
          ),
          Container(
            width: 150,
            height: 200,
            color: Colors.orange,
          ),
          Container(
            width: 100,
            height: 200,
            color: Colors.red,
          ),

        ],
      ),
    );
  }
}
