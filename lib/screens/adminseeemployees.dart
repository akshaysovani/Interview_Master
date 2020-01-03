import 'package:flutter/material.dart';
import 'package:interview_master/models/employee.dart';
import 'package:interview_master/screens/authenticate/newuserregister.dart';
import 'package:interview_master/screens/hiringmanageraddrequirementtest.dart';
import 'package:interview_master/screens/hiringmanagerseecandidates.dart';
//import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/services/database.dart';
import 'package:provider/provider.dart';

import 'adminaddemployee.dart';
//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class AdminSeeEmployees extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminSeeEmployeesState();
  }
}

class AdminSeeEmployeesState extends State<AdminSeeEmployees> {
  //int count = 0;
  List<Employee> employeeList;

  @override
  Widget build(BuildContext context) {
    employeeList = Provider.of<List<Employee>>(context) ?? [];

    if (employeeList == null) {
      employeeList = List<Employee>();
    }

    return Scaffold(
      appBar: AppBar(
          title: Text('Employees'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                goToStartPage();
              }),
          
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return NewUserRegister(ifAdmin: true);
                          }));
          //goToHiringManagerAddRequirementTest(Requirement(5,'','',''), 'Add Requirement');
        },
        tooltip: 'Add Employee',
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  ListView getListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.title;
    TextStyle subTitleStyle = Theme.of(context).textTheme.subtitle;
    return ListView.builder(
        itemCount: this.employeeList.length,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              /*leading: GestureDetector(
                onTap: () {},
                child: Icon(Icons.info,
                //    color: Colors.black
                ),
              ),*/
              title: Text(
                //'\n'+
                this.employeeList[position].name,
                style: TextStyle(
                    color: Colors.blue[900],
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              subtitle: Text(
                //'\n' +
                this.employeeList[position].role
                //  + '\n'
                ,
                style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Colors.grey[7000],
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
              ),
              trailing: SizedBox(
                width: 80.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      //color: Colors.blue,
                      child: GestureDetector(
                        onTap: () {
                          String toBePassed = 'Edit - ' + this.employeeList[position].name;
                          goToAdminAddEmployee(this.employeeList[position],toBePassed);
                        },
                        child: Icon(Icons.edit
                          //color: Colors.blue
                        ),
                      ),
                    ),
                    Container(width: 25,),
                    GestureDetector(
                      onTap: () async{
                        var result = await DatabaseService().deleteCurrentEmployee(this.employeeList[position]);
                      },
                      child: Icon(Icons.delete
                        //color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void goToStartPage(){
    Navigator.pop(context);
  }

  void goToAdminAddEmployee(Employee employee, String addOrDelete){
      Navigator.push(context, MaterialPageRoute(builder: (context){
      return AdminAddEmployee(employee,addOrDelete);
    }));
  }
}