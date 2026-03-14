import 'package:flutter/material.dart';

class PageSimpleForm extends StatefulWidget {
  const PageSimpleForm({super.key});

  @override
  State<PageSimpleForm> createState() => _PageSimpleFormState();
}

class _PageSimpleFormState extends State<PageSimpleForm> {

  //ambil value dari widget input form
  TextEditingController txtUsername = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();

  //get value --> type object
  //object --> ke String


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Page Simple Form"),
      ),

      body: Column(
        children: [
          SizedBox(height: 20,),
          Card(
            child: Container(
              width: double.infinity,
              height: 100,
              color: Colors.lightBlue,
              child: Text("Fom Simple Login"),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: txtUsername,
              decoration: InputDecoration(
                  labelText:  'Username',
                  labelStyle: TextStyle(
                      color: Colors.lightBlue
                  )
              ),
            ),
          ),

          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.all(10),
            child:
            TextFormField(
              controller: txtPassword,
              obscureText: true,//biar bulat-bulat atau gak keliatan passwordnya
              decoration: InputDecoration(
                  labelText:  'Password',
                  labelStyle: TextStyle(
                      color: Colors.lightBlue
                  )
              ),
            ),

          ),

          SizedBox(height: 10),
          Container(
            width: 200,
            child: ElevatedButton(onPressed: (){

              //convert objet to String
              String nUsername = txtUsername.text.toString();
              String nPassword = txtPassword.text.toString();

              print("Username anda adalah "+ nUsername + " dan password : ${nPassword}");

              print("Anda klik button login");

              //Latihan
              //Pengecekan username dan password
              //1, kalau username = admin, password admin --> akan pindah ke page utama
              //2. kalau username atau password salah --> tidak bisa pindah dan ada print "username atau password salah"
            }, child: Text("Login"),),
          )
        ],
      ),

    );
  }
}

