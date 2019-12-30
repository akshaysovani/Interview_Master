import 'package:flutter/material.dart';
import 'package:interview_master/screens/recruiteraddcandidate.dart';
import 'package:interview_master/screens/recruiterseeroundsofcandidate.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/candidate.dart';
import 'package:interview_master/services/database.dart';
import 'package:provider/provider.dart';

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
    candidateList = Provider.of<List<Candidate>>(context) ?? [];
    if (candidateList == null) {
      candidateList = List<Candidate>();
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
            goToRecruiterAddCandidate(Candidate(), 'Add New Candidate');
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
              title: Text(
                this.candidateList[position].name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: Colors.blue[900]),
              ),
              trailing: SizedBox(
                width: 80.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      //color: Colors.blue,
                      child: GestureDetector(
                        onTap: () {
                          String title = 'Edit - ' + this.candidateList[position].name;
                          goToRecruiterAddCandidate(this.candidateList[position],title);
                        },
                        child: Icon(Icons.edit
                            //color: Colors.blue
                            ),
                      ),
                    ),
                    Container(
                      width: 25,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var result = await DatabaseService().deleteCurrentCandidate(this.candidateList[position]);
                      },
                      child: Icon(Icons.delete
                          //color: Colors.red,
                          ),
                    )
                  ],
                ),
              ),
              onTap: (){
                goToRecruiterSeeRoundsOfCandidate(this.candidateList[position]);
              },
            ),
          );
        });
  }
  void goToRecruiterAddCandidate(Candidate candidate, String addOrEdit){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return RecruiterAddCandidate(candidate,addOrEdit);
    }));

  }
  void goToRecruiterSeeRoundsOfCandidate(Candidate candidate){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return RecruiterSeeRoundsOfCandidate(candidate);
    }));
  }
}