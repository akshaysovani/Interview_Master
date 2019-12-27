import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:interview_master/models/candidate.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/round.dart';
import 'package:interview_master/services/database.dart';

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
  var _experience = ['Fresher', 'Developer', 'Lead', 'Architect'];
  var _currentvalueselected = '';

  TextEditingController nameController = TextEditingController();

  initState() {
    super.initState();
    _currentvalueselected = _experience[0];
  }

  List<String> primarySkills;
  List<String> secondarySkills;
  List<String> softSkills;
  List<String> allSkills;
  List<bool> pressAttention;
  List<bool> longpressAttention;

  List<String> projectList;
  AutoCompleteTextField projectTextField;
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  @override
  Widget build(BuildContext context) {

    if (projectList == null){
      projectList = List(); 
      projectList.add('Project alpha');
      projectList.add('Project beta');
      projectList.add('Project gamma');
    }

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
              controller: nameController,
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


          Padding(
            padding: EdgeInsets.only(
              top: 40,
              left: 30,
              right: 20,
            ),
            child: DropdownButton<String>(
              items: _experience.map((String value){
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
              padding: EdgeInsets.only(
                //top: 10,
                left: 20,
                right: 20,
              ),
              child: projectTextField = AutoCompleteTextField<String>(
                key: key,
                suggestions: projectList,
                clearOnSubmit: false,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  // filled: true,
                  hintText: 'Project Name',
                  hintStyle: TextStyle(color: Colors.blue[900]),
                ),
                style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.blue[900],
                  fontSize: 18
                ),
                itemFilter: (item,query){
                  return item.toLowerCase().startsWith(query.toLowerCase());
                },  
                itemSorter: (a,b){
                  return a.compareTo(b);
                },
                itemSubmitted: (item){
                  setState(() {
                    projectTextField.textField.controller.text = item;
                  });
                },
                itemBuilder: (context, item){
                  //ui for autocomplete row
                  return row(item);
                }
              )),
          // Project Name  



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
                    onPressed: () async{
                      String primarySkillName = getPrimarySkill();
                      List<String> secondarySkillsNames = getSecondarySkills();
                      List<String> softSkillsNames = getSoftSkills();

                      print(primarySkillName);
                      print(secondarySkillsNames);
                      print(softSkillsNames);
                      print(_currentvalueselected);
                      print(projectTextField.textField.controller.text);
                      
                      var result = await DatabaseService()
                        .addNewCandidate(Candidate(name: nameController.text,primarySkill: primarySkillName, secondarySkills: secondarySkillsNames, softSkills: softSkillsNames, experienceLevel: _currentvalueselected, projectName: projectTextField.textField.controller.text, roundsInfo: [Round(roundNumber: '0', status: 'dummy round', feedback: 'dummy feedback', interviewerName: 'dummy name')])); // Update it
                      _save();  
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
    Navigator.pop(context);
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

  Color getColour(int position){
    if (pressAttention[position]) {
     return Colors.green;
    }else if (longpressAttention[position]){
      return Colors.red;
    }else{
      return Colors.grey;
    }
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

  String getPrimarySkill(){
    int counter=-1;
    int pos=0;
    String returnVal = '';

    for (bool val in longpressAttention){
      counter++;
      if (val == true){
        pos = counter;  
        break;
      }
    }

    counter=-1;
    for (String skill in allSkills){
      counter++;
      if (counter == pos){
        returnVal = skill;    
      }
    }
    return returnVal;
  }

  List<String> getSecondaryAndSoftSkills(){
    List<String> returnVal = List();

    int counter=-1;
    List<int> positions = List();

    for (bool val in pressAttention){
      counter++;
      if (val == true){
        positions.add(counter);  
      }
    }

    counter=-1;
    for (String skill in allSkills){
      counter++;
      if (positions.contains(counter)){
        returnVal.add(skill);    
      }
    }
    return returnVal;
  }
  
  List<String> getSecondarySkills(){
    List<String> returnVal = List();
    List<String> bothSkills = getSecondaryAndSoftSkills();
    for (String skill in bothSkills){
        if (secondarySkills.contains(skill)){
            returnVal.add(skill);
        }
    }
    return returnVal;
  }

  List<String> getSoftSkills(){
    List<String> returnVal = List();
    List<String> bothSkills = getSecondaryAndSoftSkills();
    for (String skill in bothSkills){
        if (softSkills.contains(skill)){
            returnVal.add(skill);
        }
    }
    return returnVal;
  }
}