import 'package:flutter/material.dart';
import 'package:interview_master/screens/hiringmanageraddrequirementtest.dart';
import 'package:interview_master/screens/hiringmanageraddrequirement.dart';
import 'package:interview_master/screens/hiringmanagerseecandidates.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/services/auth.dart';
import 'package:interview_master/services/database.dart';
import 'package:provider/provider.dart';

class HiringManagerSeeRequirements extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HiringManagerSeeRequirementsState();
  }
}

class HiringManagerSeeRequirementsState extends State<HiringManagerSeeRequirements> {
  int count = 0;
  List<Requirement> requirementList;
  
  @override
  Widget build(BuildContext context) {
    requirementList = Provider.of<List<Requirement>>(context) ?? [];
    //print(requirementList); 

    requirementList.forEach((requirement){
      print('primary skill is' + requirement.primarySkill);
    });

    if (requirementList == null) {
      requirementList = List<Requirement>();
      //print(requirementList); 
      /* requirementList.add(Requirement(1, 'Java', ['Confidence','Communication'],'Developer','Project alpha',''));
      requirementList.add(Requirement(2, 'Python', ['Confidence','Communication'], 'Fresher','Project beta',''));
      requirementList.add(Requirement(3, 'C++', ['Confidence','Communication'], 'Developer','Project gamma',''));
      requirementList.add(Requirement(4, 'Java', ['Confidence','Communication'], 'Architect','Project gamma','')); */
    }
    
    return Scaffold(
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
          goToHiringManagerAddRequirementTest(Requirement(), 'Add Requirement');
        },
        tooltip: 'Add Requirement',
        child: Icon(Icons.add, color: Colors.white,),
      ),
    ); 
  }

  ListView getListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.title;
    TextStyle subTitleStyle = Theme.of(context).textTheme.subtitle;
    return ListView.builder(
        itemCount: requirementList.length,
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
              title: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Text(
                //'\n'+
                this.requirementList[position].primarySkill
                    + '  -  ' + this.requirementList[position].experienceLevel
                ,
                style: TextStyle(
                    color: Colors.blue[900],
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.bold,
                    fontSize: 19
                ),
              ),
              ),


              subtitle: Padding(
                padding: EdgeInsets.only( bottom: 10),
                child: Text(
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


              trailing: SizedBox(
                height: 40,
                width: 80.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      //color: Colors.blue,
                      child: GestureDetector(
                        onTap: () {
                          String title = 'Edit - ' + this.requirementList[position].primarySkill + ' - ' + this.requirementList[position].experienceLevel;
                          goToHiringManagerAddRequirementTest(this.requirementList[position],title);
                        },
                        child: Icon(Icons.edit
                          //color: Colors.blue
                        ),
                      ),
                    ),
                    Container(width: 25,),
                    GestureDetector(
                      onTap: () async {
                          var result = await DatabaseService().deleteCurrentRequirement(this.requirementList[position]);
                        },
                      child: Icon(Icons.delete
                        //color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
              onTap: (){
                String title = this.requirementList[position].primarySkill + '  -  ' +  this.requirementList[position].experienceLevel;
                goToHiringManagerSeeCandidates(title);
              },
            ),
          );
        });
  }

  void goToHiringManagerAddRequirementTest(Requirement requirement, String addoredit){
    Navigator.push(context, MaterialPageRoute(builder: (context){
          return HiringManagerAddRequirementTest(requirement, addoredit);
    }));
  }

  void goToHiringManagerSeeCandidates(String title){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return HiringManagerSeeCandidates(title);
    }));
  }

  void goToStartPage(){
    Navigator.pop(context);
  }
}
