import 'package:flutter/material.dart';
import 'package:interview_master/screens/recruiteraddcandidate.dart';
import 'package:interview_master/screens/recruiterseeroundsofcandidate.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/candidate.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class RecruiterSeeCandidatesByRequirement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecruiterSeeCandidatesByRequirementState();
  }
}

class RecruiterSeeCandidatesByRequirementState
    extends State<RecruiterSeeCandidatesByRequirement> {
  //int count = 0;
  List<Candidate> candidateList;

  @override
  Widget build(BuildContext context) {
    if (candidateList == null) {
      candidateList = List<Candidate>();
      /* candidateList.add(Candidate(1, 'Akshay Sovani', 'Developer', 'Java'));
      candidateList.add(Candidate(1, 'Sanket Karandikar', 'Fresher', 'C++'));
      candidateList.add(Candidate(1, 'Nachiket Gundi', 'Architect', 'Java')); */
    }
    return Scaffold(
        /*appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // goToPreviousPage();
              }),
          title: Text('Java - Developer - Project alpha'),
        ),*/

        body: getListView(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[900],
          onPressed: () {
            goToRecruiterAddCandidate();
          },
          tooltip: 'Add Requirement',
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
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
              /* title: Text(
                this.candidateList[position].name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: Colors.blue[900]),
              ), */
              /* trailing: SizedBox(
                width: 80.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      //color: Colors.blue,
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.edit
                            //color: Colors.blue
                            ),
                      ),
                    ),
                    Container(
                      width: 25,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.delete
                          //color: Colors.red,
                          ),
                    )
                  ],
                ),
              ), */
              onTap: (){
                //goToRecruiterSeeRoundsOfCandidate(this.candidateList[position].name);
              },
            ),
          );
        });
  }
  void goToRecruiterAddCandidate(){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return RecruiterAddCandidate();
    }));

  }
  void goToRecruiterSeeRoundsOfCandidate(String candidateName){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return RecruiterSeeRoundsOfCandidate(candidateName);
    }));
  }
}