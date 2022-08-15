import 'package:admin/user_interfaces/login.dart';
import 'package:admin/user_interfaces/test.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';

class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  TextEditingController email = new TextEditingController();
  TextEditingController otp = new TextEditingController();
  Email_OTP myauth = Email_OTP();
  var snackBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFd10404),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            color: Colors.black87,), onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
          );
        },
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFFd10404),
                          Color(0xFFcdb03),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: email,
                            decoration: const InputDecoration(hintText: "User Email")),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            myauth.setConfig(
                              appEmail: "",
                              appName: "Asclepius",
                              userEmail: email.text,
                            );
                            if (await myauth.sendOTP() == true) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("OTP has been sent"),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Oops, OTP send failed"),
                              ));
                            }
                          },
                          child: const Text("Send OTP")),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFFd10404),
                          Color(0xFFcdb03),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: otp,
                            decoration:
                            const InputDecoration(hintText: "Enter OTP")),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (await myauth.verifyOTP(otp: otp.text) == true) {
                              snackBar = SnackBar(content: Text("Login Successful"));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Test(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Invalid OTP"),
                              ));
                            }
                          },
                          child: const Text("Verify")),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
