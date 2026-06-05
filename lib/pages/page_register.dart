import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mi2a_project_dasar/pages/page_login.dart';
import 'package:mi2a_project_dasar/services/api_service.dart';

class PageRegister extends StatefulWidget {
  const PageRegister({super.key});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _namaLengkapController = TextEditingController();

  void register() async{
    if(_usernameController.text.isEmpty || _passwordController.text.isEmpty || _emailController.text.isEmpty ||
        _namaLengkapController.text.isEmpty){
      _showSnackBar("Semua field harus diisi");
      return;
      print("Semua field harus diisi");
    }
    try{
      //mengirim data ke register.php menggunakan POST
      final response = await http.post(Uri.parse(ApiService.urlRegister),
        body: {
          'username' : _usernameController.text,
          'password' : _passwordController.text,
          'email' : _emailController.text,
          'fullname' : _namaLengkapController.text,
        },
      );

      final data = jsonDecode(response.body);

      if (data['is_success'] == true) {
        _showSnackBar("Registrasi berhasil");
        //kita arahakan page login
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            PageLogin()));
      }else{
        String pesanGagal = data['message'] ?? "Registrasi gagal";
        _showSnackBar("Registrasi gagal ${pesanGagal}");
      }
    }catch(e){
      _showSnackBar('Terjadi kesalahan saat melakukan registrasi ${e}');
    }
  }

  void _showSnackBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _namaLengkapController,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
                onPressed: register,
                child: Text("Register"),
              ),
            )
          ]
        ),
      ),
    );
  }
}
