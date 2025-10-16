import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/main.dart';

void main() {
  runApp(endscreen());
}

class endscreen extends StatelessWidget {
  const endscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: enddummyscreen(),
      theme: ThemeData.dark(),
    );
  }
}

class enddummyscreen extends StatelessWidget {
  const enddummyscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
      Positioned(
        top: 560,
        left: 140,
        child: Container(
          child: ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>todohomescreen()));
          }, child: Icon(Icons.arrow_back,color: Colors.white,),style: TextButton.styleFrom(
            backgroundColor: Color(0xFF3d4c5a),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(10),
            minimumSize: Size(150, 50),
          ),)
        ),
      ),
        Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: Text(
          "THE END",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 80,
            color: Colors.white,
          ),
        ),
      ),

        ],
      ),
    );
  }
}
