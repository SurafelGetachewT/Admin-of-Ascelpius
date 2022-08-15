import 'package:admin/user_interfaces/test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchIndex extends StatefulWidget {
  const SearchIndex({Key? key}) : super(key: key);

  @override
  _SearchIndexState createState() => _SearchIndexState();
}

class _SearchIndexState extends State<SearchIndex> {
  final _auth = FirebaseAuth.instance;
  //final Map data;
  //form key
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController nameIndexController = new TextEditingController();
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
    final nameIndexField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: nameIndexController,
      keyboardType: TextInputType.text,
      //validator
      validator: (value) {
        if (value!.isEmpty) {
          return ("Index cannot be Empty");
        }
        return null;
      },

      onSaved: (value)
      {
        nameIndexController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.medical_information),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Index of This Disease Name",
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
    final submitNameIndexButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFFd10404),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          submitNameIndex(nameController.text,nameIndexController.text);
        },
        child: Text(
          "Submit Disease Index",
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
              builder: (context) => Test(),
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
                      SizedBox(height: 10,),
                      nameField,
                      SizedBox(height: 25,),
                      nameIndexField,
                      SizedBox(height: 25,),
                      submitNameIndexButton,
                      SizedBox(height: 25,),
                    ],
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }

  void submitDrugIndex(String drugIndex) {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('index').doc('Drugs');
    documentReference.update({"Drugs":FieldValue.arrayUnion([drugIndex])});
  }

  void submitSymptomIndex(String symptomIndex) {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('index').doc('Symptoms');
    documentReference.update({"Symptoms":FieldValue.arrayUnion([symptomIndex])});
  }

  void submitTreatmentIndex(String treatmentIndex) {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('index').doc('Treatments');
    documentReference.update({"Treatments":FieldValue.arrayUnion([treatmentIndex])});
  }

  Future submitNameIndex(String diseaseName, String diseaseNameIndex) async{
    if(_formKey.currentState!.validate()){
      var document = await FirebaseFirestore.instance.collection('nameindex').doc(diseaseName).get();
      document.exists;
      if(document.exists){
        DocumentReference documentReference = FirebaseFirestore.instance.collection('nameindex').doc(diseaseName);
        documentReference.update({diseaseName:FieldValue.arrayUnion([diseaseNameIndex])});
      }
      else{
        SnackBar snackBar = SnackBar(content: Text("Disease name doesn't exist, Please insert the data first"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}

