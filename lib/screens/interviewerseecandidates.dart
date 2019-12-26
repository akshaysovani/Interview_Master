import 'package:flutter/material.dart';
import 'package:interview_master/screens/interviewerseeroundsofcandidate.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/candidate.dart';
import 'package:interview_master/services/auth.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class InterviewerSeeCandidates extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InterviewerSeeCandidatesState();
  }
}

class InterviewerSeeCandidatesState extends State<InterviewerSeeCandidates> {
  final AuthService _authService = AuthService();
  //int count = 0;
  List<Candidate> candidateList;

  @override
  Widget build(BuildContext context) {
    if (candidateList == null) {
      candidateList = List<Candidate>();

      /* candidateList.add(Candidate(1, 'Akshay Sovani', 'Developer', 'Java'));
      candidateList.add(Candidate(1, 'Sanket Karandikar', 'Fresher', 'C++'));
      candidateList.add(Candidate(1, 'Nachiket Gundi', 'Architect', 'Java')); */

      /*requirementList[0].id = 1;
      requirementList[0].title = 'Java';
      requirementList[0].no_of_vacancies = 2;
      //requirementList[0].date_updated = ;
      requirementList[1].id = 2;
      requirementList[1].title = 'Sales Representative';
      requirementList[1].no_of_vacancies = 4;
*/
      // updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        /* leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // goToPreviousPage();
              goToStartPage();
            }), */
        title: Text('Candidates'),
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
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add Requirement',
        child: Icon(Icons.add),
      ),*/
    );
  }

  ListView getListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.title;
    TextStyle subTitleStyle = Theme.of(context).textTheme.subtitle;
    return ListView.builder(
        itemCount: this.candidateList.length,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(
                this.candidateList[position].name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21, color: Colors.blue[900]),
              ),
              subtitle: Text(
                this.candidateList[position].experienceLevel,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500
                ),
              ),
              trailing: SizedBox(
                width: 130,
                child: Text(
                    'Cleared Round 2',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,
                      //    color: Colors.blue[900]
                    )
                ),
              ),
              onTap: (){
                goToInterviewerSeeRoundsOfCandidate(this.candidateList[position].name);
              },
              /*trailing: SizedBox(
                width: 80.0,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.edit),
                    ),
                    Container(width: 25,),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.delete),
                    )
                  ],
                ),
              ),*/

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

  void goToInterviewerSeeRoundsOfCandidate(String candidateName){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return InterviewerSeeRoundsOfCandidate(candidateName);
    }));
  }
}