import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/All_screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class RecruiterAddCandidate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecruiterAddCandidateState();
  }
}

class RecruiterAddCandidateState extends State<RecruiterAddCandidate> {
  @override
  var _experience = ['Fresher', 'Developer', 'Lead', 'Architect'];
  var _currentvalueselected = '';

  initState() {
    super.initState();
    _currentvalueselected = _experience[0];
  }

  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //backgroundColor: Colors.grey[800],
        title: Text('Add Candidate'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              goToRecruiterSeeCandidate();
              // goToPreviousPage();
            }),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: TextField(
              style: textStyle,
              //controller: tc,
              decoration: InputDecoration(
                labelText: 'Candidate Name',
                //hintText: 'e.g. 2',
                labelStyle: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 18,
                    fontFamily: 'Open Sans'),
              ),
            ),
          ),
          // Candidate Name

          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: DropdownButton<String>(
              items: _experience.map((String value) {
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
          ),

          Padding(
              padding: EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Center(
                child: Text(
                  'Long Press to add primary skill ' +
                      '\n' +
                      'Single tap to add secondary skills',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              )),
          //Text

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
                      'AI',
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

          Padding(
              padding: EdgeInsets.only(
                top: 50,
                left: 20,
                right: 20,
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

  void _actiononchange(String newValue) {
    setState(() {
      this._currentvalueselected = newValue;
    });
  }

  void _save(){
    goToRecruiterSeeCandidate();
    _showAlertDialogue('Success', 'Candidate Added');
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

  void goToRecruiterSeeCandidate(){
    Navigator.pop(context);
  }
}