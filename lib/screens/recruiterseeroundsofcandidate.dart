import 'package:flutter/material.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/candidate.dart';
import 'package:interview_master/models/round.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/All_screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class RecruiterSeeRoundsOfCandidate extends StatefulWidget {
  Candidate candidate;
  RecruiterSeeRoundsOfCandidate(this.candidate);

  @override
  State<StatefulWidget> createState() {
    return RecruiterSeeRoundsOfCandidateState(this.candidate);
  }
}

class RecruiterSeeRoundsOfCandidateState extends State<RecruiterSeeRoundsOfCandidate> {
  Candidate candidate;
  RecruiterSeeRoundsOfCandidateState(this.candidate);

  //int count = 0;
  List<Round> roundsList;
  List<Round> roundsUpdatedList;

  @override
  Widget build(BuildContext context) {
    if (roundsUpdatedList == null){
      roundsUpdatedList = List();
    }

    if (roundsList == null) {
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
              goToRecruiterSeeCandidates();
            }),
        title: Text(candidate.name),
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
                child: Text('\n'+this.roundsUpdatedList[position].status,
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
  void goToRecruiterSeeCandidates(){
    Navigator.pop(context);
  }
}