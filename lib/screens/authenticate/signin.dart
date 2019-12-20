import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/screens/authenticate/newuserregister.dart';
import 'package:interview_master/services/auth.dart';
import 'package:interview_master/shared/loading.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/All_screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignInState();
  }
}

class SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  bool loading = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String error = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle;
    return loading ? LoadingWidget() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              LoginImageAsset(),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter username' : null,
                controller: usernameController,
                style: textStyle, //controller: tc,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelText: 'Username',
                  //hintText: 'e.g. 2',
                  labelStyle: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 18,
                      fontFamily: 'Open Sans'),
                ),
              ),
              /* SizedBox(
                height: 20,
              ), */
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter Password' : null,
                  obscureText: true,
                  style: textStyle,
                  controller: passwordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    labelText: 'Password',
                    //hintText: 'e.g. 2',
                    labelStyle: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 18,
                        fontFamily: 'Open Sans'),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    top: 40,
                  ),
                  child: SizedBox(
                    width: 50,
                    height: 44,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.blue)),
                        //color: Colors.white,
                        color: Colors.blue[900],
                        textColor: Colors.white,
                        child: Text(
                          'LOGIN',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;  
                            });
                            dynamic result = await _auth.signInWithEmailAndPassword(usernameController.text, passwordController.text);
                            if (result == null){
                              setState(() {
                                error = 'Error signing In..';  
                                loading = false;
                              });
                            }
                          }

                          /*dynamic result = await _auth.signInAnon();
                      if (result != null){
                          print('signed in');
                          print(result.id);
                      }else{
                        print('error');
                      }*/

                          //print(usernameController.text);
                          //print(passwordController.text);
                        }),
                  )),
               SizedBox(
                height: 20,
              ), 
              
              Center(
                child: Text(error, style: TextStyle(color: Colors.red, fontSize: 18)),
              ),

              Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                  ),
                  child: getSignUpText())
            ],
          ),
        ),
      ),
    );
  }

  Widget getSignUpText() {
    return Row(
      children: <Widget>[
        Container(
          width: 40,
        ),
        Text('Don\'t have an account? ',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontFamily: 'Open Sans')),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NewUserRegister();
            }));
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
                color: Colors.blue[900], fontSize: 18, fontFamily: 'Open Sans'),
          ),
        )
      ],
    );
  }
}

class LoginImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage = AssetImage('assets/images/login.png');
    Image image = Image(
      image: assetImage,
      height: 250,
      width: 300,
    );
    return Container(child: image);
  }
}