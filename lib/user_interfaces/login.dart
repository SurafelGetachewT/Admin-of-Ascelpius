import 'package:admin/user_interfaces/email.dart';
import 'package:admin/user_interfaces/home.dart';
import 'package:flutter/material.dart';
import 'package:admin/user_interfaces/signup.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //firebase
  final _auth = FirebaseAuth.instance;

  var snackBar;

  // string for displaying the error Message
  String? errorMessage;

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      //validator
      validator: (value){
        if(value!.isEmpty){
          return("Please Enter your email");
        }
        //Regx expression for email validation
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z]+.[a-z]").hasMatch(value))
          {
            return("Enter Valid Email");
          }
      },
      onSaved: (value)
      {
        emailController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        hintStyle: TextStyle(
          color: Colors.white,
          decorationColor: Colors.white,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFd10404)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFd10404)),
        ),
      ),

    );
    //password field
    final passwordField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: passwordController,
      obscureText: true,

      //validator
      validator: (value){
         RegExp regExp = new RegExp(r'^.{6,}$');
         if(value!.isEmpty){
           return("Password field requierd");
         }
         if(!regExp.hasMatch(value)){
           return("Password must have 6 or more character");
         }
      },
      onSaved: (value)
      {
        passwordController.text=value!;
      },
      textInputAction: TextInputAction.done,

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFd10404)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFd10404)),
        ),
      ),

    );
    //Login Field
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFFd10404),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          login(emailController.text, passwordController.text);
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    //login with phone
    final loginWithPhoneButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFFd10404),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).
          pushReplacement(MaterialPageRoute(builder: (context)=> Home()));
        },
        child: Text(
          "Login with phone number",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    //login with email verification
    final loginWithEmailVerification = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFFd10404),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).
          pushReplacement(MaterialPageRoute(builder: (context)=> Email()));
        },
        child: Text(
          "Login with email verification",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return Scaffold(
      //backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        //backgroundColor: Colors.redAccent,
        backgroundColor: Color(0xFFd10404),
        elevation: 0,
        //backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
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
        child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 45,),
                      emailField,
                      SizedBox(height: 25,),
                      passwordField,
                      SizedBox(height: 35,),
                      loginButton,
                      SizedBox(height: 15,),
                      loginWithPhoneButton,
                      SizedBox(height: 15,),
                      loginWithEmailVerification,
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account? ",
                          style: (
                          TextStyle(
                            color: Colors.white,
                          )
                          ),),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder:
                                      (context)=>SignUp()));
                            },
                            child: Text(
                              "Sign Up",
                              style: (
                                  TextStyle(
                                      color: Color(0xFFd10404),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15 )
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }
  //Login Function
  void login(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) =>
        {
        snackBar = SnackBar(content: Text("Login Successful")),
        ScaffoldMessenger.of(context).showSnackBar(snackBar),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Home())),
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        snackBar = SnackBar(content: Text(errorMessage!));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}