import 'package:admin/user_interfaces/login.dart';
import 'package:admin/user_interfaces/signup.dart';
import 'package:admin/user_interfaces/test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_auth/email_auth.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailController1 = TextEditingController();
  TextEditingController emailOtpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  User? user;
  String verificationID = "";
  var snackBar;
  EmailAuth? emailAuth = new EmailAuth(
    sessionName: "Sample session",
  );

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
      //backgroundColor: Colors.redAccent,
      //backgroundColor: Color(0xFFd10404),
      body: Container(
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
          children: [
            TextFormField(
              controller: phoneController,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Phone number is required for login");
                }
                if (value.length<9) {
                  return ("Enter Valid Phone number");
                }

                if (value.length>11) {
                  return ("Enter Valid Phone number");
                }
              },
              onSaved: (value)
              {
                phoneController.text=value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: 'Phone Number',
                prefix: Padding(
                  padding: EdgeInsets.all(4),
                  child: Text('+234'),
                ),
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
              maxLength: 10,
              keyboardType: TextInputType.phone,
            ),
              Visibility(
              child: TextField(
                controller: otpController,
                decoration: InputDecoration(
                  hintText: 'OTP',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(''),
                  ),
                ),
                maxLength: 6,
                keyboardType: TextInputType.number,
              ),
              visible: otpVisibility,
            ),
            SizedBox(
              height: 10,
            ),

            MaterialButton(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              minWidth: MediaQuery.of(context).size.width,
              color: Color(0xFFd10404),
              onPressed: () {
                if (otpVisibility) {
                  verifyOTP();
                } else {
                  loginWithPhone();
                }
              },
              child: Text(
                otpVisibility ? "Login" : "Verify",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
  void loginWithPhone() async {
      auth.verifyPhoneNumber(
        phoneNumber: "+251" + phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {
            print("You are logged in successfully");
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          otpVisibility = true;
          verificationID = verificationId;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
  }
  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
          (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      },
    ).whenComplete(
          () {
        if (user != null) {
          snackBar = SnackBar(content: Text("Login Successful"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Test(),
            ),
          );
        } else {
          snackBar = SnackBar(content: Text("Login Failed"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }

  sendOTP() async {
    //EmailAuth(sessionName: "Test");
    var res = await emailAuth!.sendOtp(recipientMail: emailController.value.text);
    if(res)
      {
        print("OTP sent");
        snackBar = SnackBar(content: Text("OTP Sent to your email"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    else{
      snackBar = SnackBar(content: Text("Unable to sent OTP"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }


  }

  verifyEmailOTP() {
    var res = emailAuth!.validateOtp(recipientMail: emailController.value.text, userOtp: emailOtpController.value.text);
    if(res){
      print("Otp verified");
      snackBar = SnackBar(content: Text("OTP verified"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignUp(),
        ),
      );
    }
  }
}
