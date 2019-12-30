import 'package:flutter/material.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:provider/provider.dart';

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
    requirementList = Provider.of<List<Requirement>>(context) ?? [];
    if (requirementList == null) {
      requirementList = List<Requirement>();
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