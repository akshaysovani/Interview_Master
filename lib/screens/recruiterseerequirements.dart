import 'package:flutter/material.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:provider/provider.dart';

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
            ),
          );
        });
  }
  void goToStartPage(){
   Navigator.pop(context);
  }
}