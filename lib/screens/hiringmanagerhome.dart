import 'package:flutter/material.dart';
import 'package:interview_master/models/candidate.dart';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/screens/hiringmanagerseerequirement.dart';
import 'package:interview_master/services/database.dart';
import 'package:provider/provider.dart';
import 'package:interview_master/services/auth.dart';

class HiringManagerHomePage extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Requirement>>.value(
      value: DatabaseService().requirements,
      child: StreamProvider<List<Candidate>>.value(
          value: DatabaseService().candidates,
          child: Scaffold(
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
      body: HiringManagerSeeRequirements(),
      ),
      )
    );  
      
   }
}