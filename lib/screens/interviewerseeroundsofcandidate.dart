import 'package:flutter/material.dart';
import 'package:interview_master/models/user.dart';
import 'package:interview_master/screens/interviewerenterfeedback.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/candidate.dart';
import 'package:interview_master/models/round.dart';
import 'package:provider/provider.dart';

class InterviewerSeeRoundsOfCandidate extends StatefulWidget {
  Candidate candidate;
  InterviewerSeeRoundsOfCandidate(this.candidate);

  @override
  State<StatefulWidget> createState() {
    return InterviewerSeeRoundsOfCandidateState(this.candidate);
  }
}

class InterviewerSeeRoundsOfCandidateState extends State<InterviewerSeeRoundsOfCandidate> {
  //int count = 0;
  Candidate candidate;
  InterviewerSeeRoundsOfCandidateState(this.candidate);

  List<Round> roundsList;
  List<Round> roundsUpdatedList;

  @override
  Widget build(BuildContext context) {
    if (roundsUpdatedList == null){
      roundsUpdatedList = List();
    }

    if (roundsList == null) {
      //roundsList = Provider.of<List<Round>>(context);
      roundsList = this.candidate.roundsInfo;
      for (Round round in roundsList){
          if (round.roundNumber != '0'){
            roundsUpdatedList.add(round);
          }
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // goToPreviousPage();
              goToInterviewerSeeCandidates();
            }),
        title: Text(this.candidate.name),
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
          print(this.candidate.roundsInfo);
          //if (this.candidate.roundsInfo.length == 1){     //yet to be interviewed even once
            goToInterviewerEnterFeedback(this.candidate);
          //}/* else{
            //goToInterviewerEnterFeedback(this.candidate.name,this.candidate.roundsInfo.last.roundNumber+1);  
          //} */
          
        },
        tooltip: 'Add Next Round Feedback',
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  ListView getListView() {
    bool fullFeedbackOn = false;
    TextStyle titleStyle = Theme.of(context).textTheme.title;
    TextStyle subTitleStyle = Theme.of(context).textTheme.subtitle;
    return ListView.builder(
        itemCount: this.roundsUpdatedList.length,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(
                '\n' +
                    this.roundsUpdatedList[position].roundNumber.toString() +
                    '    ' +
                    this.roundsUpdatedList[position].interviewerName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, color: Colors.blue[900]),
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '\n' + this.roundsUpdatedList[position].feedback + '\n',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    //maxLines: fullFeedbackOn ? 10 : 1,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),

              trailing: SizedBox(
                width: 40,
                child: Text('\n'+this.roundsUpdatedList[position].status,
                    style:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
              ),
            ),
          );
        });
  }
  
  void goToInterviewerSeeCandidates(){
    Navigator.pop(context);
  }

  void goToInterviewerEnterFeedback(Candidate candidate){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return InterviewerEnterFeedback(candidate);
    }));
  }
}