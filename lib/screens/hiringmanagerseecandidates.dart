import 'package:flutter/material.dart';
import 'package:interview_master/screens/hiringmanagerseeroundsofcandidate.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/candidate.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class HiringManagerSeeCandidates extends StatefulWidget {
  String languageAndExperienceTitle;

  HiringManagerSeeCandidates(this.languageAndExperienceTitle);
  @override
  State<StatefulWidget> createState() {
    return HiringManagerSeeCandidatesState(this.languageAndExperienceTitle);
  }
}

class HiringManagerSeeCandidatesState extends State<HiringManagerSeeCandidates> {
  //int count = 0;
  String languageAndExperienceTitle;
  HiringManagerSeeCandidatesState(this.languageAndExperienceTitle);

  List<Candidate> candidateList;

  @override
  Widget build(BuildContext context) {
    if (candidateList == null) {
      candidateList = List<Candidate>();

      /* candidateList.add(Candidate(1, 'Sanket Karandikar', 'Fresher', 'C++'));
      candidateList.add(Candidate(2, 'Akshay Sovani', 'Developer', 'Java'));
      candidateList.add(Candidate(3, 'Nachiket Gundi', 'Architect', 'Java')); */
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              goToHiringManagerSeeRequirements();
            }),
        title: Text(this.languageAndExperienceTitle),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[900]),
              ),
              trailing: SizedBox(
                width: 130,
                child: Text(
                    'Cleared Round 2',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                      //    color: Colors.blue[900]
                    )
                ),
              ),

              onTap: (){
                goToHiringManagerSeeRoundsOfCandidate(this.candidateList[position].name);
              },
            ),
          );
        });
  }
  void goToHiringManagerSeeRequirements(){
    Navigator.pop(context);
  }

  void goToHiringManagerSeeRoundsOfCandidate(String candidateName){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return HiringManagerSeeRoundsOfCandidate(candidateName);
    }));
  }
}