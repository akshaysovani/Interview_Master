import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class HiringManagerAddRequirementTest extends StatefulWidget {

  Requirement requirement;
  String addOrEdit;

  HiringManagerAddRequirementTest(this.requirement, this.addOrEdit);

  @override
  State<StatefulWidget> createState() {
    return HiringManagerAddRequirementTestState(this.requirement, this.addOrEdit);
  }
}

class HiringManagerAddRequirementTestState
    extends State<HiringManagerAddRequirementTest> {

  Requirement requirement;
  String addOrEdit;

  HiringManagerAddRequirementTestState(this.requirement, this.addOrEdit);

  List<String> primarySkills;
  List<String> secondarySkills;
  List<String> softSkills;
  List<String> allSkills;
  List<bool> pressAttention;
  List<bool> longpressAttention;

  @override
  Widget build(BuildContext context) {

    if (primarySkills == null){
      primarySkills = List<String>();
      primarySkills.add('Java');
      primarySkills.add('C++');
      primarySkills.add('Python');
      primarySkills.add('C#.net');
      primarySkills.add('Problem Solving');
    }

    if (secondarySkills == null){
      secondarySkills = List<String>();
      secondarySkills.add('R');
      secondarySkills.add('SQL');

    }

    if (softSkills == null){
      softSkills = List<String>();
      softSkills.add('Communication');
      softSkills.add('Confidence');
      softSkills.add('Attitude');
      softSkills.add('Timeliness');
      softSkills.add('Logical Ability');
    }

    if (allSkills == null){
      allSkills = List<String>();

      for (String skill in primarySkills){
        allSkills.add(skill);
      }
      for (String skill in secondarySkills){
        allSkills.add(skill);
      }
      for (String skill in softSkills){
        allSkills.add(skill);
      }
    }

    if (pressAttention == null){
      pressAttention = List<bool>();
      for (int i=0;i<allSkills.length;i++){
        pressAttention.add(false);
      }
    }

    if (longpressAttention == null){
      longpressAttention = List<bool>();
      for (int i=0;i<allSkills.length;i++){
        longpressAttention.add(false);
      }
    }
    //for (int i=0;i<allSkills.length;i++){
      //debugPrint(pressAttention[i].toString());
    //}


    TextStyle textStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //backgroundColor: Colors.grey[800],
        title: Text(addOrEdit),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              goToHiringManagerSeeRequirements();
            }),
      ),

      body: ListView(
        //shrinkWrap: false,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
              child: Center(
                child: Text(
                  'Long Press to add primary skill ' +
                      '\n' +
                      'Single tap to add secondary skills',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              )),
          //Text

          Container(
            height: 400,
            width:  200,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: allSkills.length,
              itemBuilder :(BuildContext context, int position){
                return Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 80,
                      right: 80,
                    ),
                    child: SizedBox(
                      width: 200,
                      height: 30,
                      child: RaisedButton(
                        //color: Theme.of(context).accentColor,
                        //color: Colors.grey[300],
                          color: getColour(position),
                          textColor: Colors.white,
                          child: Text(
                            allSkills[position],
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              pressAttention[position] = !pressAttention[position];
                            });
                          },
                        onLongPress: (){
                              setState(() {
                                longpressAttention[position] = !longpressAttention[position];
                              });
                        },

                          ),
                    )
                  //Java

                );
              }
          ),
          ),

/*
          Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 120,
                right: 120,
              ),
              child: SizedBox(
                width: 50,
                height: 35,
                child: RaisedButton(
                  //color: Theme.of(context).accentColor,
                  //color: Colors.grey[300],
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text(
                      'Java',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {});
                    }),
              )
            //Java
          ),
          Padding(
              padding: EdgeInsets.only(
                top: 10,
                left: 120,
                right: 120,
              ),
              child: SizedBox(
                width: 50,
                height: 35,
                child: RaisedButton(
                    color: Colors.grey[300],
                    textColor: Colors.black,
                    child: Text(
                      'C++',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {});
                    }),
              )),
          //C++
          Padding(
              padding: EdgeInsets.only(
                top: 5,
                left: 120,
                right: 120,
              ),
              child: SizedBox(
                width: 50,
                height: 35,
                child: RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    //color: Colors.grey[300],
                    //textColor: Colors.black,
                    child: Text(
                      'Python',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {});
                    }),
              )),
          //Python
          Padding(
              padding: EdgeInsets.only(
                top: 5,
                left: 120,
                right: 120,
              ),
              child: SizedBox(
                width: 50,
                height: 35,
                child: RaisedButton(
                    color: Colors.grey[300],
                    textColor: Colors.black,
                    child: Text(
                      'SQL',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {});
                    }),
              )),
          Padding(
              padding: EdgeInsets.only(
                top: 5,
                left: 120,
                right: 120,
              ),
              child: SizedBox(
                width: 50,
                height: 35,
                child: RaisedButton(
                    color: Colors.grey[300],
                    textColor: Colors.black,
                    child: Text(
                      'C#.NET',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {});
                    }),
              )),
          //Communication
          Padding(
              padding: EdgeInsets.only(
                top: 5,
                left: 120,
                right: 120,
              ),
              child: SizedBox(
                width: 50,
                height: 35,
                child: RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    //color: Colors.grey[300],
                    //textColor: Colors.black,
                    child: Text(
                      'R',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {});
                    }),
              )),
          //R
          */


          Padding(
              padding: EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
              ),
              child: AutoCompleteTextField(
                decoration: new InputDecoration(
                  //suffixIcon: Container(
                  //width: 85.0,
                  //height: 60.0,
                  //),
                  contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  // filled: true,
                  hintText: 'Project Name',
                  hintStyle: TextStyle(color: Colors.blue[900]),
                ),
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              )),
          // Project Name

          Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: AutoCompleteTextField(
                decoration: new InputDecoration(
                  //suffixIcon: Container(
                  //width: 85.0,
                  //height: 60.0,
                  //),
                  contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  // filled: true,
                  hintText: 'Customer Name',
                  hintStyle: TextStyle(color: Colors.blue[900]),
                ),
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              )),
          // Customer Name

          Padding(
              padding: EdgeInsets.only(
                top: 40,
                left: 20,
                right: 20,
                bottom: 30
              ),
              child: SizedBox(
                width: 50,
                height: 35,
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
                    onPressed: () {
                      setState(() {
                        _save();
                      });
                    }),
              ))
        ],
      ),
    );
  }

  void goToHiringManagerSeeRequirements(){
    Navigator.pop(context);
  }

  void _save(){
    goToHiringManagerSeeRequirements();
    _showAlertDialogue('Success', 'Requirement Added');
  }

  void _showAlertDialogue(String title,String msg){
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

  Color getColour(int position){
    if (pressAttention[position]) {
     return Colors.green;
    }else if (longpressAttention[position]){
      return Colors.red;
    }else{
      return Colors.grey;
    }
  }
}