import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interview_master/models/candidate.dart';
import 'package:interview_master/models/user.dart';
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
  User user;

  @override
  
/* 
  Future<String> _getCurrentUser() async{
    FirebaseUser user = await _auth.currentUser();
    //print('uid'+user.uid);
    User usr = AuthService().getUserFromFirebaseUser(user);
    return await DatabaseService().getName(usr);
  } */

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    requirementList = Provider.of<List<Requirement>>(context) ?? [];

    if (requirementList == null) {
      requirementList = List<Requirement>();
    }
    
    if (requirementListForThisHiringManager == null){
      requirementListForThisHiringManager = List();
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
      ),  
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
          goToHiringManagerAddRequirement(Requirement(), 'Add New Requirement');
        },
        tooltip: 'Add Requirement',
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
    //print(requirementList); 
  }

  Widget getListView() {
    return FutureBuilder<String>( 
      future: getName(user),
      builder: (BuildContext buildContext, AsyncSnapshot<String> snapshot){
        List<String> nameAndRole;
        String snapName;
        String snapRole;
        debugPrint(snapshot.data);

        if(snapshot.data != null){
          nameAndRole = snapshot.data.split(',');
        }
        if (nameAndRole != null){
          snapName = nameAndRole[0];
          snapRole = nameAndRole[1];
        }
        
        if (snapshot.hasError){
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        //print(snapshot.data);
        requirementListForThisHiringManager.clear();
        if (snapRole == 'Admin'){
          requirementListForThisHiringManager.addAll(requirementList);
        }else{
          for (Requirement requirement in requirementList){
              if (requirement.owner == snapName){
                  requirementListForThisHiringManager.add(requirement);
              }
          } 
        }
        
        return ListView.builder(
        itemCount: requirementListForThisHiringManager.length,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
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
                          goToHiringManagerAddRequirement(this.requirementListForThisHiringManager[position],title);
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

    );
    
    
  }

  void goToHiringManagerAddRequirement(Requirement requirement, String addoredit){
    Navigator.push(context, MaterialPageRoute(builder: (context){
          return HiringManagerAddRequirement(requirement, addoredit);
    }));
  }

  void goToHiringManagerSeeCandidates(Requirement requirement){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return HiringManagerSeeCandidates(requirement);
    }));
  }

  Future<String> getName(User user) async{
    resultName = '';
    if (user != null){
      var userQuery = await Firestore.instance.collection('user').where('id', isEqualTo: user.id).getDocuments().then((data){ 
          if (data.documents.length > 0){
                    //print('In getRole');
                    resultName = data.documents[0].data['fullName'] + ',' + data.documents[0].data['role'];
                    //print(role);
         
          }});
    }
      return resultName;
  }  
}
