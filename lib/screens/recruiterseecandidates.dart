import 'package:flutter/material.dart';
import 'package:interview_master/screens/recruiteraddcandidate.dart';
import 'package:interview_master/screens/recruiterseeroundsofcandidate.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/candidate.dart';
import 'package:interview_master/services/database.dart';
import 'package:provider/provider.dart';
import 'package:interview_master/screens/recruiterseecandidatesandrequirements.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class RecruiterSeeCandidatesByRequirement extends StatefulWidget {
  List<Candidate> candidateListToBeDisplayed;
  RecruiterSeeCandidatesByRequirement({this.candidateListToBeDisplayed});

  @override
  RecruiterSeeCandidatesByRequirementState createState() => RecruiterSeeCandidatesByRequirementState();
  
}

class RecruiterSeeCandidatesByRequirementState
    extends State<RecruiterSeeCandidatesByRequirement> {

  

  //int count = 0;
  bool dummy;

  @override
  Widget build(BuildContext context) {
      
      

    /* if (!dummy){
    candidateList = Provider.of<List<Candidate>>(context) ?? [];
    candidateListToBeDisplayed = List();
    candidateListToBeDisplayed.addAll(candidateList);
    } */

    /* for (Candidate candidate in candidateListToBeDisplayed){
      print(candidate.experienceLevel);
    } */
    //print(dummy);


    /* if (candidateList == null) {
      candidateList = List<Candidate>();
    } */

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

  /* void filterSearchResults (String query){
    List<Candidate> dummyCandidateList = List();
    debugPrint(candidateList.length.toString());
    for (Candidate candidate in candidateList){
        print(candidate.experienceLevel);
    }
    //dummyCandidateList.addAll(candidateList);
    //debugPrint(dummyCandidateList.length.toString());
    if (query.isNotEmpty){
      List<Candidate> dummyListData = List();
      dummyCandidateList.forEach((candidate){
      if (candidate.name.toLowerCase().contains(query.toLowerCase())){
          dummyListData.add(candidate);
      }
      });
      setState(() {
        candidateListToBeDisplayed.clear();
        candidateListToBeDisplayed.addAll(dummyListData);
        dummy = true;
      });
    } else{
      setState(() {
        candidateListToBeDisplayed.clear();
        candidateListToBeDisplayed.addAll(candidateList);
        dummy = false;
      });
    } 
  } */

  ListView getListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.title;
    TextStyle subTitleStyle = Theme.of(context).textTheme.subtitle;
    return ListView.builder(
        itemCount: widget.candidateListToBeDisplayed.length,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(
                widget.candidateListToBeDisplayed[position].name,
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
                          String title = 'Edit - ' + widget.candidateListToBeDisplayed[position].name;
                          goToRecruiterAddCandidate(widget.candidateListToBeDisplayed[position],title);
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
                        var result = await DatabaseService().deleteCurrentCandidate(widget.candidateListToBeDisplayed[position]);
                      },
                      child: Icon(Icons.delete
                          //color: Colors.red,
                          ),
                    )
                  ],
                ),
              ),
              onTap: (){
                goToRecruiterSeeRoundsOfCandidate(widget.candidateListToBeDisplayed[position]);
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