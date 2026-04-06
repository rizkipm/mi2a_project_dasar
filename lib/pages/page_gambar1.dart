import 'package:flutter/material.dart';

class PageGambar1 extends StatelessWidget {
  const PageGambar1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rumah Gadang"),
        backgroundColor: Colors.brown,
      ),

      body: Center(
        child: Image.asset("images/gambar1.jpg"),
      ),
    );
  }
}

//set di bagian puspec.yaml
//import gambar
// untuk gambar harus sesuai nama dan extensionnya kayak png, jpg, jpeg
// nama file harus huruf kecil, tidak boleh spasi atau huruf besar
