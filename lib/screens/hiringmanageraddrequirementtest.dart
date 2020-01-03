import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:interview_master/models/candidate.dart';
import 'package:interview_master/models/primarySkill.dart';
import 'package:interview_master/models/project.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/secondarySkill.dart';
import 'package:interview_master/models/softSkill.dart';
import 'package:interview_master/models/user.dart';
import 'package:interview_master/services/database.dart';
import 'package:provider/provider.dart';

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

  var _experience = ['Fresher', 'Developer', 'Lead', 'Architect'];
  var _currentvalueselected = '';

  bool firstTimeLoad;
  Requirement requirement;
  String addOrEdit;

  HiringManagerAddRequirementTestState(this.requirement, this.addOrEdit);

  List<PrimarySkill> primarySkills;
  List<SecondarySkill> secondarySkillsFromDB;
  List<SoftSkill> softSkills;
  List<String> allSkills;
  List<bool> pressAttention;
  List<bool> longpressAttention;

  List<Project> projectList;
  AutoCompleteTextField projectTextField;
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  initState() {
    firstTimeLoad = true;
    super.initState();
    if (requirement.primarySkill != null){                      //edit requirement  
      //print('inside setstate: '+requirement.experienceLevel);
          _currentvalueselected = requirement.experienceLevel;
      
          WidgetsBinding.instance.addPostFrameCallback((_) =>
          key.currentState.textField.controller.text = requirement.projectName);

          //projectTextField.textField.controller.text = requirement.projectName;    
      
      //projectTextField.textField.controller.text = requirement.projectName;
      //customerTextField.textField.controller.text = requirement.customerName;
    }else{                                                      //add new requirement  
      _currentvalueselected = _experience[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    primarySkills = Provider.of<List<PrimarySkill>>(context);
    secondarySkillsFromDB = Provider.of<List<SecondarySkill>>(context);
    softSkills = Provider.of<List<SoftSkill>>(context);
    projectList = Provider.of<List<Project>>(context);
    for (Project project in projectList){
        debugPrint('project: '+project.name);
    }
    //List<dynamic> primarySkills = Provider.of<List<dynamic>>(context);
    //var candidateList = Provider.of<List<Candidate>>(context) ?? [];
    //TextEditingController projectController = TextEditingController();
    //TextEditingController customerController = TextEditingController();
    //AutoCompleteTextField

    User user = Provider.of<User>(context);
    
    if (projectList == null){
      projectList = List<Project>(); 
      /* projectList.add('Project alpha');
      projectList.add('Project beta');
      projectList.add('Project gamma'); */
    }

    if (primarySkills == null){
      primarySkills = List<PrimarySkill>();
     /*  primarySkills.add('Java');
      primarySkills.add('C++');
      primarySkills.add('Python');
      primarySkills.add('C#.net');
      primarySkills.add('Problem Solving'); */
    }

    if (secondarySkillsFromDB == null){
      secondarySkillsFromDB = List<SecondarySkill>();
     /*  secondarySkills.add('R');
      secondarySkills.add('SQL');
 */
    }

    if (softSkills == null){
      softSkills = List<SoftSkill>();
      /* softSkills.add('Communication');
      softSkills.add('Confidence');
      softSkills.add('Attitude');
      softSkills.add('Timeliness');
      softSkills.add('Logical Ability'); */
    }

    if (allSkills == null){
      allSkills = List<String>();

      for (PrimarySkill skill in primarySkills){
        allSkills.add(skill.skillName);
      }

      for (SecondarySkill skill in secondarySkillsFromDB){
        allSkills.add(skill.skillName);
      }
      for (SoftSkill skill in softSkills){
        allSkills.add(skill.skillName);
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

    //Initial skills colour load
    if (firstTimeLoad){
      if (requirement.primarySkill != null){                      //edit requirement  
        String reqPrimarySkill = requirement.primarySkill;
        List<dynamic> reqSecondarySkills = requirement.secondarySkills;
        List<dynamic> reqSoftSkills = requirement.softSkills;
        
        //Setting up primary skill 
        int counter=-1;
        int pos=0;
        for (String skill in allSkills){
          counter++;
          if (skill == reqPrimarySkill){
            pos = counter;  
            break;
          }
        }
        //counter=-1;
        for (int i=0;i<longpressAttention.length;i++){
          if (i==pos){
            longpressAttention[i] = !longpressAttention[i];
          }
        }

        //Setting up secondary skills
        for (String secSkill in reqSecondarySkills){
          counter=-1;
          pos=0;
          for (String skill in allSkills){
            counter++;
            if (skill == secSkill){
              pos = counter;  
              break;
            }
          }  
          for (int i=0;i<pressAttention.length;i++){
            if (i==pos){
              pressAttention[i] = !pressAttention[i];
            }
          }
        }

        //Setting up soft skills
        for (String softSkill in reqSoftSkills){
          counter=-1;
          pos=0;
          for (String skill in allSkills){
            counter++;
            if (skill == softSkill){
              pos = counter;  
              break;
            }
          }  
          for (int i=0;i<pressAttention.length;i++){
            if (i==pos){
              pressAttention[i] = !pressAttention[i];
            }
          }
        }

      } 
      firstTimeLoad = false;
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
                      'Single tap to add secondary and soft skills',
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
                              if (!checkIfSkillisPrimary(allSkills[position])){
                              pressAttention[position] = !pressAttention[position];
                              }
                            });
                          },
                        onLongPress: (){
                              setState(() {
                                if (checkIfSkillisPrimary(allSkills[position])){
                                  longpressAttention[position] = !longpressAttention[position];
                                }
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
              top: 50,
              left: 30,
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
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: projectTextField = AutoCompleteTextField<String>(
                key: key,
                suggestions: getProjectListStringFromProjectType(),
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
                left: 20,
                right: 20,
              ),
              child: AutoCompleteTextField(
                //controller: customerController,
                //itemSubmitted: ,
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
                    onPressed: () async{ 
                      if (validationIsSuccessful()){
                      String primarySkillName = getPrimarySkill();
                      List<String> secondarySkillsNames = getSecondarySkills();
                      List<String> softSkillsNames = getSoftSkills();

                      if (requirement.primarySkill == null){      //adding new requirement 
                        var result = await DatabaseService()
                        .addNewRequirement(Requirement(primarySkill: primarySkillName, secondarySkills: secondarySkillsNames, softSkills: softSkillsNames, experienceLevel: _currentvalueselected, projectName: projectTextField.textField.controller.text),user); // Update it
                      }else{                                    //Editing current requirement
                        var result = await DatabaseService()
                        .editCurrentRequirement(Requirement(id: requirement.id, primarySkill: primarySkillName, secondarySkills: secondarySkillsNames, softSkills: softSkillsNames, experienceLevel: _currentvalueselected, projectName: projectTextField.textField.controller.text),user); // Update it                        
                      }
                      _save();                      
                      }else{
                        _showAlertDialogue('Please try again','Please enter valid information');
                      } 
                    }
                    ),
              ))
        ],
      ),
    );
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

  void goToHiringManagerSeeRequirements(){
    Navigator.pop(context);
  }

  void _save(){
    goToHiringManagerSeeRequirements();
    _showAlertDialogue('Success', 'Requirement Saved');
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

  void _actiononchange(String newValue) {
    setState(() {
      this._currentvalueselected = newValue;
    });
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
    bothSkills.forEach((secondaryskill){
      print(secondaryskill);
    });
    for (String skill in bothSkills){
      if (secondarySkillsFromDB != null){
        for (SecondarySkill secskill in secondarySkillsFromDB){
          if (secskill.skillName == skill){
              returnVal.add(skill);
          }
        }
      }
    }
    return returnVal;
  }

  List<String> getSoftSkills(){
    List<String> returnVal = List();
    List<String> bothSkills = getSecondaryAndSoftSkills();
    for (String skill in bothSkills){
      if (softSkills != null){
        for (SoftSkill sofskill in softSkills){
          if (sofskill.skillName == skill){
              returnVal.add(skill);
          }
        }  
      }
    }
    return returnVal;
  }
  List<String> getProjectListStringFromProjectType(){
    List<String> toBeReturned = List();
    for (Project project in projectList){
        toBeReturned.add(project.name);
    }
    return toBeReturned;
  }

  bool checkIfSkillisPrimary(String skill){
    for (PrimarySkill primarySkill in primarySkills){
      if (primarySkill.skillName == skill){
        return true;    
      }  
    }
    return false;
  }
  bool validationIsSuccessful(){
    int counter=0;
    for (bool val in longpressAttention){
      if (val == true){
         counter+=1; 
      }    
    }
    if (counter != 1){
      return false;    
    }
    return true;
  }
}