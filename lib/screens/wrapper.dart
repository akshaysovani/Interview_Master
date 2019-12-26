import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interview_master/models/user.dart';
import 'package:interview_master/screens/authenticate/authenticate.dart';
import 'package:interview_master/screens/hiringmanagerhome.dart';
import 'package:interview_master/screens/hiringmanagerseerequirement.dart';
import 'package:interview_master/screens/interviewerseecandidates.dart';
import 'package:interview_master/screens/recruiterseecandidatesandrequirements.dart';
import 'package:interview_master/screens/startpage.dart';
import 'package:interview_master/services/database.dart';
import 'package:provider/provider.dart';
//import 'package:interview_master/models/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String role = '';

  /* initState(){
    super.initState();
     getRole( ).then((roleVal) {
       role = roleVal; 
    }); 
  }
 */
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    
    //print('user is:' + user.toString());
    

    return FutureBuilder<String>(
      future: getRole(user),
      builder: (BuildContext buildContext, AsyncSnapshot<String> snapshot){
        /* if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: Text('Please wait its loading...'));
        } */          
           if (snapshot.hasError){
              return Center(child: Text('Error: ${snapshot.error}'));
           }else{
             print('Snapshot data:' +snapshot.data);
             //snapshot.data
             if (snapshot.data == ''){
                return Authenticate();
             }
             else if (snapshot.data == 'Hiring Manager'){
                //return HiringManagerSeeRequirements();
                return HiringManagerHomePage();
             }
             else if (snapshot.data == 'Recruiter'){
                //return HiringManagerSeeRequirements();
                return RecruiterSeeCandidatesAndRequirements();
             }
             else if (snapshot.data == 'Interviewer'){
                //return HiringManagerSeeRequirements();
                return InterviewerSeeCandidates();
             }
              /* return Scaffold(
                appBar: AppBar(),
                body: Container(
                  //child: Text('${snapshot.data}'),
                  child: Text(snapshot.data),
                ),
              ); */
              //(child: new Text('${snapshot.data}'));  
           }
        
            return StartPage();
      },
     );
  }

  Future<String> getRole(User user) async{
    role = '';
    //var user = await FirebaseAuth.instance.currentUser();
    print('In getRole start');
    print(user);
    if (user != null){
      print('In getRole start');
      var userQuery = await Firestore.instance.collection('user').where('id', isEqualTo: user.id).getDocuments().then((data){ 
          if (data.documents.length > 0){
                    print('In getRole');
                    role = data.documents[0].data['role'];
                    //print(role);
         
          }});
      print('userQuery:'+userQuery.toString());
      print('Role:'+role);
      /* userQuery.getDocuments().then((data){ 
          if (data.documents.length > 0){
                    print('In getRole');
                    role = data.documents[0].data['role'];
                    print(role);
         
          }});
 */

/* 



      DocumentReference userReference = Firestore.instance.collection('user').document(user.id);
      DocumentSnapshot userSnapshot = await userReference.get();
      role = userSnapshot['role'];
      print(role);
 */


      /* var result = await Firestore.instance.collection('user').document(user.id).get().then((DocumentSnapshot ds){
      role = ds['role'];
      print(role.toString());
      }); */
    }
      //String abcd = "Hiring Manager";
      return role;
  }  
}