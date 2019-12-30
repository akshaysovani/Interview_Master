import 'package:flutter/material.dart';
import 'package:interview_master/models/round.dart';
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
  List<Candidate> candidateListForThisRequirement;


  @override
  Widget build(BuildContext context) {
    candidateList = Provider.of<List<Candidate>>(context) ?? [];
    /* candidateList.forEach((candidate){
       print(candidate.experienceLevel); 
    }); */

    /* if (candidateList == null) {
      candidateList = List<Candidate>();
    } */

    if (candidateListForThisRequirement == null){
      candidateListForThisRequirement = List<Candidate>();
      for (Candidate candidate in candidateList){
        if (candidate.primarySkill == requirement.primarySkill && candidate.experienceLevel == requirement.experienceLevel){
          candidateListForThisRequirement.add(candidate);
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
        itemCount: this.candidateListForThisRequirement.length,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Text(
                this.candidateListForThisRequirement[position].name,
                style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 21, color: Colors.blue[900]
                  ),
              ),
              ),
              trailing: SizedBox(
                width: 150,
                child: getText(this.candidateListForThisRequirement[position])
              ),

              onTap: (){
                goToHiringManagerSeeRoundsOfCandidate(this.candidateListForThisRequirement[position]);
              },
            ),
          );
        });
  }

  Text getText(Candidate candidate){
    int passCounter = 0;
    if (candidate.roundsInfo.last.roundNumber == '0'){
      return Text('');
    }else{
      for (Round round in candidate.roundsInfo){
        if (round.status == 'Pass'){
          passCounter += 1;   
        }  
      }
      return Text('Cleared Rounds:  ' + passCounter.toString() + '/' + candidate.roundsInfo.last.roundNumber,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,
                      )
              );  
    }
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