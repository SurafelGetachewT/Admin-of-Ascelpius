import 'package:admin/user_interfaces/index.dart';
import 'package:admin/user_interfaces/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final _auth = FirebaseAuth.instance;
  //final Map data;
  //form key
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController treatmentController = new TextEditingController();
  final TextEditingController drugController = new TextEditingController();
  final TextEditingController symptomController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    //Name field
    final nameField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.text,
      //validator
      validator: (value) {
        if (value!.isEmpty) {
          return ("Name cannot be Empty");
        }
        return null;
      },

      onSaved: (value)
      {
        nameController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.medical_information),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Name of The Disease",
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //Treatment field
    final treatmentField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: treatmentController,
      keyboardType: TextInputType.text,
      //validator
      validator: (value) {
        if (value!.isEmpty) {
          return ("Treatment can not be empty");
        }
        return null;
      },

      onSaved: (value)
      {
        treatmentController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.medical_services),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Treatments",
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //Drug field
    final drugField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: drugController,
      keyboardType: TextInputType.text,
      //validator
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter drugs");
        }
        return null;
      },

      onSaved: (value)
      {
        drugController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vaccines),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Drugs",
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //Symptom field
    final symptomField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: symptomController,

      //validator
      validator: (value) {
        if (value!.isEmpty) {
          return ("symptoms can't be empty");
        }
      },

      onSaved: (value)
      {
        symptomController.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.medication),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Symptom",
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //Submit Field
    final submitButtonData = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFFd10404),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
         addData(nameController.text, symptomController.text, treatmentController.text, drugController.text);
        },
        child: Text(
          "Submit Data",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    //Prepare search index
    final searchIndexButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFFd10404),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SearchIndex()));
        },
        child: Text(
          "Search Index",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
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
                      SizedBox(height: 25,),
                      nameField,
                      SizedBox(height: 25,),
                      symptomField,
                      SizedBox(height: 25,),
                      treatmentField,
                      SizedBox(height: 25,),
                      drugField,
                      SizedBox(height: 15,),
                      submitButtonData,
                      SizedBox(height: 15,),
                      searchIndexButton,
                    ],
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }
  void addData(String name, String symptom, String treatments, String drug) {
    if(_formKey.currentState!.validate()){
      Map<String,dynamic> demoData ={
        "name":nameController.text,
        "symptom":symptomController.text,
        "treatment":treatmentController.text,
        "drug":drugController.text,
      };
      DocumentReference documentReference = FirebaseFirestore.instance.collection('data').doc(nameController.text);
      documentReference.set(demoData);
      DocumentReference documentReference1 = FirebaseFirestore.instance.collection('nameindex').doc(nameController.text);
      documentReference1.set({nameController.text:FieldValue.arrayUnion([nameController.text])});

      Map<String,dynamic> indexData ={
        nameController.text:nameController.text,
      };
    }
  }
}

