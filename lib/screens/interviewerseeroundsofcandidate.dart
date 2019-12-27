import 'package:flutter/material.dart';
import 'package:interview_master/screens/interviewerenterfeedback.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/candidate.dart';
import 'package:interview_master/models/round.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

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

  @override
  Widget build(BuildContext context) {
    if (roundsList == null) {
      //roundsList = List<Round>();
      roundsList = this.candidate.roundsInfo;
      /* roundsList.add(Round(1, 'Pass', 'Interviewer 1',
          'Excellent reading and writing skills, moderate communication skills, moderate technical skills'));
      roundsList.add(Round(2, 'Pass', 'Interviewer 2',
          'Nice reading and writing skills, moderate communication skills'));
      roundsList.add(Round(3, 'Fail', 'Interviewer 3', 'Not good enough technical skills')); */
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
          if (this.candidate.roundsInfo.isEmpty){     //yet to be interviewed even once
            goToInterviewerEnterFeedback(this.candidate);
          }/* else{
            goToInterviewerEnterFeedback(this.candidate.name,this.candidate.roundsInfo.last.roundNumber+1);  
          } */
          
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
        itemCount: this.roundsList.length,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(
                '\n' +
                    this.roundsList[position].roundNumber.toString() +
                    '    ' +
                    this.roundsList[position].interviewerName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, color: Colors.blue[900]),
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '\n' + this.roundsList[position].feedback + '\n',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    //maxLines: fullFeedbackOn ? 10 : 1,
                    textAlign: TextAlign.start,
                  ),
                  /*InkWell(
                    onTap: (){ setState(() {
                      fullFeedbackOn = !fullFeedbackOn;
                    }); },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        fullFeedbackOn ? Text("Show Less",style: TextStyle(color: Colors.blue),) :  Text("Show More",style: TextStyle(color: Colors.blue))
                      ],
                    ),
                  ),*/
                ],
              ),

              trailing: SizedBox(
                width: 40,
                child: Text('\n'+this.roundsList[position].status,
                    style:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
              ),
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
  
  void goToInterviewerSeeCandidates(){
    Navigator.pop(context);
  }

  void goToInterviewerEnterFeedback(Candidate candidate){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return InterviewerEnterFeedback(candidate);
    }));
  }
}