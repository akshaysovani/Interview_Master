import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/radiobuttonmodel.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class InterviewerEnterFeedback extends StatefulWidget {
  String candidateName;
  InterviewerEnterFeedback(this.candidateName);

  @override
  State<StatefulWidget> createState() {
    return InterviewerEnterFeedbackState(this.candidateName);
  }
}

class InterviewerEnterFeedbackState extends State<InterviewerEnterFeedback> {
  String candidateName;
  InterviewerEnterFeedbackState(this.candidateName);

  int _radioCurrentValue = 1;
  String _currentText = '';

  List<RadioButtonModel> _radioList;

  @override
  Widget build(BuildContext context) {
    if (_radioList == null) {
      _radioList = List<RadioButtonModel>();
      _radioList.add(RadioButtonModel(1, 'Pass'));
      _radioList.add(RadioButtonModel(2, 'Fail'));
    }

    TextStyle textStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      appBar: AppBar(
        title: Text(candidateName),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // goToPreviousPage();
              goToInterviewerSeeRoundsOfCandidate();
            }),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 35, left: 10, right: 10),
              child: Center(
                child: Text(
                  'Add Feedback',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              )),
          //Text

          Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              style: textStyle,
              //controller: tc,
              decoration: InputDecoration(
                labelText: 'Interview Round Number',
                hintText: 'e.g. 2',
                labelStyle: TextStyle(
                  color: Colors.blue[900], fontSize: 18,
                  fontFamily: 'Open Sans'
                ),
              ),
            ),
          ),

          Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: AutoCompleteTextField(
                decoration: new InputDecoration(
                  //suffixIcon: Container(
                  //width: 85.0,
                  //height: 60.0,
                  //),
                  //contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  // filled: true,
                  labelText: 'Interviewer Name',
                  //hintText: 'Customer Name',
                  labelStyle: TextStyle(color: Colors.blue[900], fontSize: 18, fontFamily: 'Open Sans',fontWeight: FontWeight.bold),
                ),
                style: new TextStyle(
                    fontFamily: 'Open Sans'
                ),
              )),
          // Interviewer Name

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
                labelText: 'Feedback',
                //hintText: 'Good in Java Spring, etc',
                labelStyle: TextStyle(color: Colors.blue[900], fontSize: 20, fontFamily: 'Open Sans'),
              ),
            ),
          ),
          //Feedback

          Padding(
            padding: EdgeInsets.only(
              top: 30,
              //left: 20,
              right: 20,
            ),
            child: Column(
                children: _radioList
                    .map((t) => RadioListTile(
                  activeColor: Colors.blue,
                          title: Text('${t.text}', style: TextStyle(
                            color: Colors.blue[900], fontSize: 18, fontWeight: FontWeight.bold
                          )),
                          groupValue: _radioCurrentValue,
                          value: t.index,
                          onChanged: (val) {
                            setState(() {
                              _radioCurrentValue = val;
                              //_currentText = t.text;
                            });
                          },
                        ))
                    .toList()),
          ),

          Padding(
              padding: EdgeInsets.only(
                top: 40,
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
/*void changeStatus(String value){
    setState(() {
      _radioValueStatus = value;
    });
  }*/
  void _save(){
    goToInterviewerSeeRoundsOfCandidate();
    _showAlertDialogue('Success', 'Feedback Added');
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

  void goToInterviewerSeeRoundsOfCandidate(){
   Navigator.pop(context);
  }
}