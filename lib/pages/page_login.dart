import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mi2a_project_dasar/pages/page_list_berita.dart';
import 'package:mi2a_project_dasar/pages/page_register.dart';
import 'package:mi2a_project_dasar/services/api_service.dart';
import 'package:mi2a_project_dasar/helper/session_manager.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _showSnackBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void login() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar("Semua field harus diisi");
      return;
      print("Semua field harus diisi");
    }
    try {
      final response = await http.post(Uri.parse(ApiService.urlLogin),
        body: {
          'username': _usernameController.text,
          'password': _passwordController.text,
        },
      );

      final data = jsonDecode(response.body);
      if (data['is_success'] == true) {
        _showSnackBar("Login berhasil");
        //arahkan ke page berita list

        //simpan data session
        await SessionManager.saveUserSession(data['data']);
        //arahkan ke page berita list
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PageListBerita()
        ));
      } else {
        String pesanGagal = data['message'] ?? "Login gagal";
        _showSnackBar("Login gagal ${pesanGagal}");
      }
    } catch (e) {
      _showSnackBar('Terjadi kesalahan saat melakukan login ${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
                onPressed: login,
                child: Text("Login"),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  // ke page register
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PageRegister()));
                },
                  child: Text('Belum punya akun? Silahkan Login')),
            ),
          ],
        ),
      )
    );
  }
}
