import 'package:flutter/material.dart';
import 'package:interview_master/screens/hiringmanagerseeroundsofcandidate.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/candidate.dart';
import 'package:interview_master/services/database.dart';
import 'package:provider/provider.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class HiringManagerSeeCandidates extends StatefulWidget {
  Requirement requirement;
  HiringManagerSeeCandidates(this.requirement);

  @override
  State<StatefulWidget> createState() {
    return HiringManagerSeeCandidatesState(this.requirement);
  }
}

class HiringManagerSeeCandidatesState extends State<HiringManagerSeeCandidates> {
  //int count = 0;
  //String languageAndExperienceTitle;
  HiringManagerSeeCandidatesState(this.requirement);
  
  Requirement requirement;
  List<Candidate> candidateList;
  List<Candidate> candidateListForThisUser;


  @override
  Widget build(BuildContext context) {
    candidateList = Provider.of<List<Candidate>>(context) ?? [];
    /* candidateList.forEach((candidate){
       print(candidate.experienceLevel); 
    }); */

    if (candidateList == null) {
      candidateList = List<Candidate>();
    }

    if (candidateListForThisUser == null){
      candidateListForThisUser = List<Candidate>();

      for (Candidate candidate in candidateList){
        if (candidate.primarySkill == requirement.primarySkill && candidate.experienceLevel == requirement.experienceLevel){
          candidateListForThisUser.add(candidate);
        }  
      }
    }

    

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              goToHiringManagerSeeRequirements();
            }),
        title: Text(this.requirement.primarySkill + ' - ' +  this.requirement.experienceLevel),
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
        itemCount: this.candidateListForThisUser.length,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(
                this.candidateListForThisUser[position].name,
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
                goToHiringManagerSeeRoundsOfCandidate(this.candidateListForThisUser[position]);
              },
            ),
          );
        });
  }
  void goToHiringManagerSeeRequirements(){
    Navigator.pop(context);
  }

  void goToHiringManagerSeeRoundsOfCandidate(Candidate candidate){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return HiringManagerSeeRoundsOfCandidate(candidate);
    }));
  }
}