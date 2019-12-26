import 'package:flutter/material.dart';
import 'package:interview_master/models/user.dart';
import 'package:interview_master/screens/adminaddemployee.dart';
import 'package:interview_master/screens/adminseeemployees.dart';
import 'package:interview_master/screens/authenticate/newuserregister.dart';
import 'package:interview_master/screens/authenticate/signin.dart';
import 'package:interview_master/screens/hiringmanagerhome.dart';
import 'package:interview_master/screens/startpage.dart';
//import 'package:interview_master/screens/loginpage.dart';
import 'package:interview_master/screens/hiringmanagerseerequirement.dart';
import 'package:interview_master/screens/hiringmanagerseecandidates.dart';
import 'package:interview_master/screens/hiringmanageraddrequirement.dart';
import 'package:interview_master/screens/hiringmanageraddrequirementtest.dart';
import 'package:interview_master/screens/hiringmanagerseeroundsofcandidate.dart';
//import 'package:interview_master/screens/interviewerfirstpage.dart';
import 'package:interview_master/screens/interviewerseecandidates.dart';
import 'package:interview_master/screens/interviewerseeroundsofcandidate.dart';
import 'package:interview_master/screens/interviewerenterfeedback.dart';
import 'package:interview_master/screens/recruiterseecandidatesandrequirements.dart';
//import 'package:interview_master/screens/test.dart';
import 'package:interview_master/screens/recruiteraddcandidate.dart';
import 'package:interview_master/screens/recruiterseerequirements.dart';
import 'package:interview_master/screens/recruiterseecandidates.dart';
import 'package:interview_master/screens/recruiterseeroundsofcandidate.dart';
//import 'package:interview_master/screens/loginpage.dart';
import 'package:interview_master/screens/wrapper.dart';
import 'package:interview_master/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(InterviewApp());
}

class InterviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(    // listen to user
      value: AuthService().user,
      //child:  StreamProvider<User>.value(   // listen to 
        //value: AuthService().userwithsds,
        child: MaterialApp(
        /*theme: ThemeData(
          primarySwatch: Colors.deepPurple
      ),*/
        theme: ThemeData(
            //brightness: Brightness.dark,
            primaryColor: Colors.blue[900],
            accentColor: Colors.grey[200],
            fontFamily: 'Open Sans'
            //backgroundColor: Colors.grey,
            ),
        debugShowCheckedModeBanner: false,
        title: 'Interview Helper',
        //home: RecruiterSeeRoundsOfCandidate(),
        //home: RecruiterAddCandidate(),
        //home: RecruiterSeeCandidatesByRequirement(),
        //home: RecruiterSeeRequirements()
        home: RecruiterSeeCandidatesAndRequirements()

        //home: InterviewerEnterFeedback(),
        //home: InterviewerSeeRoundsOfCandidate()
        //home: InterviewerSeeCandidates()
        //home: InterviewerFirstPage()
        //home: HiringManagerSeeRoundsOfCandidate()
        //home: HiringManagerSeeCandidates()
        //home: HiringManagerAddRequirement(),
        //home: HiringManagerAddRequirementTest(),
        //home: HiringManagerSeeRequirements()
        //home: HiringManagerHomePage()
        //home: LoginPage()
        //home: Wrapper()
        //home: SignIn()
        //home: NewUserRegister()
    ),
      //)
      );
    
   
  }
}