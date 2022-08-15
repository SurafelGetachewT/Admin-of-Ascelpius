import 'dart:async';
import 'package:admin/user_interfaces/login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
        //()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()))
    Timer(Duration(seconds: 8), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.redAccent,
        backgroundColor: Color(0xFFd10404),
        elevation: 0,
        //backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      //backgroundColor: Colors.redAccent,
      //backgroundColor: Color(0xFFd10404),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFd10404),
              Color(0xFF0a0101),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
