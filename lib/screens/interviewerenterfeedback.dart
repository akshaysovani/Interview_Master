import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:interview_master/models/candidate.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/radiobuttonmodel.dart';
import 'package:interview_master/models/round.dart';
import 'package:interview_master/services/database.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class InterviewerEnterFeedback extends StatefulWidget {
  Candidate candidate;

  InterviewerEnterFeedback(this.candidate);

  @override
  State<StatefulWidget> createState() {
    return InterviewerEnterFeedbackState(this.candidate);
  }
}

class InterviewerEnterFeedbackState extends State<InterviewerEnterFeedback> {
  Candidate candidate;
  String status='';

  InterviewerEnterFeedbackState(this.candidate);

  int _radioCurrentValue = 1;
  String _currentText = '';

  List<RadioButtonModel> _radioList;
  
  TextEditingController roundNumberController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  AutoCompleteTextField interviewerTextField;
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  List<String> interviewerList;

  initState() {
    super.initState();
    if (this.candidate.roundsInfo.isEmpty){
      roundNumberController.text = '1'; 
    }else{
      int currentRound = int.parse(candidate.roundsInfo.last.roundNumber);
      currentRound += 1;
      roundNumberController.text = currentRound.toString();   
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_radioList == null) {
      _radioList = List<RadioButtonModel>();
      _radioList.add(RadioButtonModel(1, 'Pass'));
      _radioList.add(RadioButtonModel(2, 'Fail'));
    }
    if (interviewerList == null){
      interviewerList = List();
      interviewerList.add('Interviewer 1');
      interviewerList.add('Interviewer 2');
      interviewerList.add('Interviewer 3');
    }

    TextStyle textStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      appBar: AppBar(
        title: Text(this.candidate.name),
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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  //color: Colors.blue[900], 
                  fontSize: 17,
                  fontFamily: 'Open Sans'
              ),
              controller: roundNumberController,
              decoration: InputDecoration(
                labelText: 'Interview Round Number',
                hintText: 'e.g. 2',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900], 
                  fontSize: 22,
                  fontFamily: 'Open Sans'
                ),
              ),
            ),
          ),

          Padding(
              padding: EdgeInsets.only(
                //top: 10,
                left: 10,
                right: 20,
              ),
              child: interviewerTextField = AutoCompleteTextField<String>(
                key: key,
                suggestions: interviewerList,
                clearOnSubmit: false,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  //labelText: 'Interviewer Name',
                  hintText: 'Interviewer Name',
                  //labelStyle: TextStyle(color: Colors.blue[900], fontSize: 18, fontFamily: 'Open Sans',fontWeight: FontWeight.bold),
                  hintStyle: TextStyle(color: Colors.blue[900]),
                ),
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                  color: Colors.black, 
                  fontSize: 17,
                  fontFamily: 'Open Sans'
                ),
                itemFilter: (item,query){
                  return item.toLowerCase().startsWith(query.toLowerCase());
                },  
                itemSorter: (a,b){
                  return a.compareTo(b);
                },
                itemSubmitted: (item){
                  setState(() {
                    interviewerTextField.textField.controller.text = item;
                  });
                },
                itemBuilder: (context, item){
                  //ui for autocomplete row
                  return row(item);
                }
              )),
          // Interviewer Name

          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: TextField(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                  //color: Colors.blue[900], 
                  fontSize: 17,
                  fontFamily: 'Open Sans'
              ),
              controller: feedbackController,
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
                top: 70,
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
                    onPressed: () async {
                      /* print(roundNumberController.text);
                      print(interviewerTextField.textField.controller.text);
                      print(feedbackController.text); */
                      if (_radioCurrentValue == 1){
                        status = 'Pass';  
                      }else{
                        status = 'Fail';    
                      }
                      var result = await DatabaseService()
                        .addNewRound(Round(roundNumber: roundNumberController.text, interviewerName: interviewerTextField.textField.controller.text, feedback: feedbackController.text, status: status),candidate); // Update it
                      print('done');  
                      _save();
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
    Navigator.pop(context);
    Navigator.pop(context);
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

  Widget row(String projectName){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(projectName,
        style: TextStyle(
          fontSize: 16,
          color: Colors.blue[900]
        ),)
      ],
    ),
    );
  }
}