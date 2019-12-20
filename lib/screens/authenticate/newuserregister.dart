import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/employee.dart';
import 'package:interview_master/services/auth.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class NewUserRegister extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewUserRegisterState();
  }
}

class NewUserRegisterState extends State<NewUserRegister> {

  final AuthService _auth = AuthService();
  String error = '';

  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();

  var _role = ['Hiring Manager', 'Recruiter', 'Interviewer'];
  var _currentvalueselected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._currentvalueselected = _role[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //backgroundColor: Colors.grey[800],
          title: Text('Sign Up'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                goToSignIn();
              }),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter Full Name' : null,
                  style: textStyle,
                  controller: fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    //hintText: 'e.g. 2',
                    labelStyle: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 18,
                        fontFamily: 'Open Sans'),
                  ),
                ),
                //Full Name

                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: DropdownButton<String>(
                  items: _role.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 18,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  value: _currentvalueselected,
                  onChanged: (String newValue) {
                    _actiononchange(newValue);
                  },
                ),
                )
                
                   
                ,
                

                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter User Name' : null,
                  style: textStyle,
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    //hintText: 'e.g. 2',
                    labelStyle: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 18,
                        fontFamily: 'Open Sans'),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter User Name' : null,
                  style: textStyle,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    //hintText: 'e.g. 2',
                    labelStyle: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 18,
                        fontFamily: 'Open Sans'),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  style: textStyle,
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    //hintText: 'e.g. 2',
                    labelStyle: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 18,
                        fontFamily: 'Open Sans'),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.blue[900])),
                    color: Colors.white,
                    textColor: Colors.blue[900],
                    child: Text(
                      'Save',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () async{
                      if (_formKey.currentState.validate()){ // valid form
                        /* print(fullNameController);
                        print(usernameController);
                        print(passwordController); */

                        dynamic result = await _auth.registerWithEmailAndPassword(fullNameController.text, _currentvalueselected, usernameController.text, passwordController.text);
                        
                        if (result == null){
                          setState(() {
                            error = 'Could not register';
                          });
                        }else{
                            _save();
                        }
                      }
                    }),
                ),

                /* SizedBox(
                  height: 20,
                  child: Text(),
                ) */

                
              ],
            ),
          ),
        ));
  }

  void goToSignIn() {
    Navigator.pop(context);
  }

  void _save() {
    goToSignIn();
    _showAlertDialogue('Success', 'Registration Successful');
  }

  void _showAlertDialogue(String title, String msg) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _actiononchange(String newValue) {
    setState(() {
      this._currentvalueselected = newValue;
    });
  }
}
