import 'package:flutter/material.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/All_screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class RecruiterSeeRequirements extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecruiterSeeRequirementsState();
  }
}

class RecruiterSeeRequirementsState extends State<RecruiterSeeRequirements> {
  int count = 0;
  List<Requirement> requirementList;

  @override
  Widget build(BuildContext context) {
    if (requirementList == null) {
      requirementList = List<Requirement>();
      /* requirementList.add(Requirement(1, 'Java', ['Confidence','Communication'],'Developer','Project alpha',''));
      requirementList.add(Requirement(2, 'Sales Representative',['Confidence','Communication'], 'Fresher','Project beta',''));
      requirementList.add(Requirement(3, 'C++',['Confidence','Communication'], 'Developer','Project gamma',''));
      requirementList.add(Requirement(3, 'Java', ['Confidence','Communication'],'Architect','Project gamma','')); */
      /*requirementList[0].id = 1;
      requirementList[0].title = 'Java';
      requirementList[0].no_of_vacancies = 2;
      //requirementList[0].date_updated = ;
      requirementList[1].id = 2;
      requirementList[1].title = 'Sales Representative';
      requirementList[1].no_of_vacancies = 4;
*/
      // updateListView();
    }
    return Scaffold(

      /*appBar: AppBar(title: Text('Requirements'),
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
        onPressed: () {
          goToStartPage();
        })),*/
      body: getListView(),
    );
  }

  ListView getListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.title;
    TextStyle subTitleStyle = Theme.of(context).textTheme.subtitle;
    return ListView.builder(
        itemCount: this.requirementList.length,
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
                this.requirementList[position].primarySkill
                    + '  -  ' + this.requirementList[position].experienceLevel
                ,
                style: TextStyle(
                    color: Colors.blue[900],
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              subtitle: Text(
                //'\n' +
                this.requirementList[position].projectName
                //  + '\n'
                ,
                style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Colors.grey[7000],
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
              ),


              /*
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ), //edit
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.delete),
                      ),
                    ),
                  )
                ],*/
            ),
          );
        });
  }
  void goToStartPage(){
   Navigator.pop(context);
  }
}