import 'package:flutter/material.dart';

class PageSimpleForm extends StatelessWidget {
  const PageSimpleForm({super.key});

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
              print("Anda klik button login");
            }, child: Text("Login"),),
          )
        ],
      ),

    );
  }
}
