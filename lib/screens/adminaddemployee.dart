import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/employee.dart';
import 'package:interview_master/screens/authenticate/newuserregister.dart';
import 'package:interview_master/screens/hiringmanagerseerequirement.dart';
import 'package:interview_master/services/database.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class AdminAddEmployee extends StatefulWidget {

  Employee employee;
  String addOrEdit;

  AdminAddEmployee(this.employee, this.addOrEdit);

  @override
  State<StatefulWidget> createState() {
    return AdminAddEmployeeState(this.employee, this.addOrEdit);
  }
}

class AdminAddEmployeeState
    extends State<AdminAddEmployee> {

  Employee employee;
  String addOrEdit;

  AdminAddEmployeeState(this.employee, this.addOrEdit);

  var _role = ['Hiring Manager','Recruiter','Interviewer','Admin'];
  var _currentvalueselected='';
  TextEditingController nameController = TextEditingController();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (employee.name != null){
      _currentvalueselected = employee.role;
      nameController.text = employee.name;
    }else{
      _currentvalueselected = _role[0];
    } 
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //backgroundColor: Colors.grey[800],
        title: Text(addOrEdit),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              goToAdminSeeEmployees();
            }),
      ),

      body: ListView(
        //shrinkWrap: false,
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
                labelText: 'Employee Name',
                //hintText: 'e.g. 2',
                labelStyle: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 18,
                    fontFamily: 'Open Sans'),
              ),
            ),
          ),
          // Employee Name  


          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
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
          ),


          Padding(
              padding: EdgeInsets.only(
                top: 360,
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
                    onPressed: () async {                        
                        var result = await DatabaseService()
                        .adminEditCurrentEmployee(Employee(id: employee.id, name: nameController.text, role: _currentvalueselected)); // Update it                        
                        _save();
                    }),
              ))
        ],
      ),
    );
  }

  void goToAdminSeeEmployees(){
    Navigator.pop(context);
  }

  void _save(){
    Navigator.pop(context);
    _showAlertDialogue('Success', 'Employee Saved Successfully');
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

  void _actiononchange(String newValue){
    setState(() {
      this._currentvalueselected = newValue;      
    });
  }
}