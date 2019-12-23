import 'package:flutter/material.dart';
import 'package:interview_master/screens/hiringmanageraddrequirementtest.dart';
import 'package:interview_master/screens/hiringmanageraddrequirement.dart';
import 'package:interview_master/screens/hiringmanagerseecandidates.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/services/auth.dart';
//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class HiringManagerSeeRequirements extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HiringManagerSeeRequirementsState();
  }
}

class HiringManagerSeeRequirementsState extends State<HiringManagerSeeRequirements> {
  final AuthService _authService = AuthService();

  int count = 0;
  List<Requirement> requirementList;

  @override
  Widget build(BuildContext context) {
    if (requirementList == null) {
      requirementList = List<Requirement>();
      requirementList.add(Requirement(1, 'Java', 'Developer','Project alpha'));
      requirementList.add(Requirement(2, 'Python', 'Fresher','Project beta'));
      requirementList.add(Requirement(3, 'C++', 'Developer','Project gamma'));
      requirementList.add(Requirement(4, 'Java', 'Architect','Project gamma'));
    }

    return Scaffold(
      appBar: AppBar(
          title: Text('Requirements'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person, color: Colors.white,),
              label: Text('Logout', style: TextStyle(color: Colors.white,
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),),
              onPressed: () async{
                await _authService.signOut();
              },
            )
          ],
          /* leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                goToStartPage();
              }) */
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
          goToHiringManagerAddRequirementTest(Requirement(5,'','',''), 'Add Requirement');
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
                this.requirementList[position].title
                    + '  -  ' + this.requirementList[position].experience_level
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
                this.requirementList[position].project_name
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
                          String title = 'Edit - ' + this.requirementList[position].title + ' - ' + this.requirementList[position].experience_level;
                          goToHiringManagerAddRequirementTest(this.requirementList[position],title);
                        },
                        child: Icon(Icons.edit
                          //color: Colors.blue
                        ),
                      ),
                    ),
                    Container(width: 25,),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.delete
                        //color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
              onTap: (){
                String title = this.requirementList[position].title + '  -  ' +  this.requirementList[position].experience_level;
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