import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interview_master/models/candidate.dart';
import 'package:interview_master/models/user.dart';
import 'package:interview_master/screens/hiringmanageraddrequirementtest.dart';
import 'package:interview_master/screens/hiringmanageraddrequirement.dart';
import 'package:interview_master/screens/hiringmanagerseecandidates.dart';
//import 'dart:async';
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
  var resultName;
  int count = 0;
  final AuthService _authService = AuthService();
  FirebaseAuth _auth;
  
  List<Requirement> requirementList;
  List<Requirement> requirementListForThisHiringManager;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser().then((name){
        setState(() {
        resultName = name;  
        print('name is 0......... '+resultName);
        });
    print('name is 1......... '+resultName);
    });
    
  }

  Future<String> _getCurrentUser() async{
    FirebaseUser user = await _auth.currentUser();
    //print('uid'+user.uid);
    User usr = AuthService().getUserFromFirebaseUser(user);
    return await DatabaseService().getName(usr);
  }

  @override
  Widget build(BuildContext context) {
    requirementList = Provider.of<List<Requirement>>(context) ?? [];

    if (requirementList == null) {
      requirementList = List<Requirement>();
    }
    
    if (requirementListForThisHiringManager == null){
      requirementListForThisHiringManager = List();
      for (Requirement requirement in requirementList){
          print('owner\n');
          print(requirement.owner);
          print('resultName\n');
          print(resultName);
          if (requirement.owner == resultName){
            print('in*********');
            requirementListForThisHiringManager.add(requirement);
          }
      }
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
          goToHiringManagerAddRequirementTest(Requirement(), 'Add New Requirement');
        },
        tooltip: 'Add Requirement',
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
     
    
    //print(requirementList); 

  }

  ListView getListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.title;
    TextStyle subTitleStyle = Theme.of(context).textTheme.subtitle;
    return ListView.builder(
        itemCount: requirementListForThisHiringManager.length,
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
                this.requirementListForThisHiringManager[position].primarySkill
                    + '  -  ' + this.requirementListForThisHiringManager[position].experienceLevel
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
                this.requirementListForThisHiringManager[position].projectName
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
                          String title = 'Edit - ' + this.requirementListForThisHiringManager[position].primarySkill + ' - ' + this.requirementListForThisHiringManager[position].experienceLevel;
                          goToHiringManagerAddRequirementTest(this.requirementListForThisHiringManager[position],title);
                        },
                        child: Icon(Icons.edit
                          //color: Colors.blue
                        ),
                      ),
                    ),
                    Container(width: 25,),
                    GestureDetector(
                      onTap: () async {
                          var result = await DatabaseService().deleteCurrentRequirement(this.requirementListForThisHiringManager[position]);
                        },
                      child: Icon(Icons.delete
                        //color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
              onTap: (){
                //String title = this.requirementList[position].primarySkill + '  -  ' +  this.requirementList[position].experienceLevel;
                goToHiringManagerSeeCandidates(this.requirementListForThisHiringManager[position]);
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

  void goToHiringManagerSeeCandidates(Requirement requirement){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return HiringManagerSeeCandidates(requirement);
    }));
  }
}
