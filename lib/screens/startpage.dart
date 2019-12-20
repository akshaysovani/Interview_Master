import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:interview_master/screens/adminseeemployees.dart';
import 'package:interview_master/screens/interviewerseecandidates.dart';
import 'package:interview_master/screens/recruiterseerequirements.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/screens/hiringmanagerseerequirement.dart';
import 'package:interview_master/screens/recruiterseecandidatesandrequirements.dart';
import 'package:interview_master/services/auth.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class StartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StartPageState();
  }
}

class StartPageState extends State<StartPage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          LoginImageAsset(),
          Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: SizedBox(
                width: 50,
                height: 44,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.blue)),
                    //color: Colors.white,
                    color: Colors.blue[900],
                    textColor: Colors.white,
                    child: Text(
                      'Hiring Manager',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      goToHiringManagerSeeRequirements();
                    }),
              )),
          Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: SizedBox(
                width: 50,
                height: 44,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.blue)),
                    //color: Colors.white,
                    color: Colors.blue[900],
                    textColor: Colors.white,
                    child: Text(
                      'Recruiter',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                        goToRecruiterSeeCandidatesAndRequirements();
                    }),
              )),
          Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: SizedBox(
                width: 50,
                height: 44,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.blue)),
                    //color: Colors.white,
                    color: Colors.blue[900],
                    textColor: Colors.white,
                    child: Text(
                      'Interviewer',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      goToInterviewerSeeCandidates();
                    }),
              )),
          Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: SizedBox(
                width: 50,
                height: 44,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.blue)),
                    //color: Colors.white,
                    color: Colors.blue[900],
                    textColor: Colors.white,
                    child: Text(
                      'Admin',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      goToAdminSeeEmployees();
                    }),
              )),

              Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: SizedBox(
                width: 50,
                height: 44,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.blue)),
                    //color: Colors.white,
                    color: Colors.blue[900],
                    textColor: Colors.white,
                    child: Text(
                      'Logout',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () async {
                        await _auth.signOut();
                    }),
              )),

          
        ],
      ),
    );
  }


  void goToHiringManagerSeeRequirements(){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return HiringManagerSeeRequirements();
    }));
  }

  void goToRecruiterSeeCandidatesAndRequirements(){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return RecruiterSeeCandidatesAndRequirements();
    }));
  }

  void goToInterviewerSeeCandidates(){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return InterviewerSeeCandidates();
    }));
  }

  void goToAdminSeeEmployees(){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return AdminSeeEmployees();
    }));
  }
}

class LoginImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage = AssetImage('assets/images/login.png');
    Image image = Image(
      image: assetImage,
      height: 230,
      width: 300,
    );
    return Container(child: image);
  }
}