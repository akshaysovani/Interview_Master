import 'package:flutter/material.dart';
import 'package:interview_master/models/candidate.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/screens/recruiterseecandidates.dart';
import 'package:interview_master/screens/recruiterseerequirements.dart';
import 'package:interview_master/services/auth.dart';
import 'package:provider/provider.dart';

//import 'package:first_flutter_app/utils/database_helper.dart';
//import 'package:first_flutter_app/screens/NoteDetail.dart';
//import 'package:sqflite/sqflite.dart';

class RecruiterSeeCandidatesAndRequirements extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecruiterSeeCandidatesAndRequirementsState();
  }
}

class RecruiterSeeCandidatesAndRequirementsState
  extends State<RecruiterSeeCandidatesAndRequirements> {

  bool callFliter;
  final AuthService _authService = AuthService();
  int count = 0;
  //List<Requirement> requirementList;

  Icon searchIcon = Icon(Icons.search);
  Widget searchBar = Text('Interview Master');

  List<Candidate> candidateList;
  List<Candidate> candidateListToBeDisplayed;
  bool dummy = false;
  int currentTabIndex;

  @override
  Widget build(BuildContext context) {
    if (!dummy){
    candidateList = Provider.of<List<Candidate>>(context) ?? [];
    candidateListToBeDisplayed = List();
    candidateListToBeDisplayed.addAll(candidateList);
    }  

    if (candidateList == null) {
      candidateList = List<Candidate>();
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: this.searchBar,
          bottom: TabBar(
            onTap: (index){
              this.currentTabIndex = index;
            },
            indicatorColor: Colors.red,
            indicatorWeight: 3.0,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.group),
                text: 'Candidates',
              ),
              Tab(
                icon: Icon(Icons.description),
                text: 'Requirements',
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: this.searchIcon,
              onPressed: () { 
                //int index = DefaultTabController.of(context).previousIndex;
                print(this.currentTabIndex);
                setState(() {
                  if (this.searchIcon.icon == Icons.search) {
                    this.searchIcon = Icon(Icons.close);
                    this.searchBar = TextField(
                      autofocus: true,
                      onChanged: (value){
                        //print(this.context.toString());
                        filterSearchResults(value);
                          /* dummy = false;
                          this.searchIcon = Icon(Icons.search);
                          this.searchBar = Text('Candidates'); */
                        
                      },
                      textInputAction: TextInputAction.go,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    );
                  } else {
                    this.searchIcon = Icon(Icons.search);
                    this.searchBar = Text('Candidates');
                    setState(() {
                      dummy = false;
                    });
                  }
                });
              },
            ),
            
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


        body: TabBarView(
          children: <Widget>[
            RecruiterSeeCandidatesByRequirement(candidateListToBeDisplayed: this.candidateListToBeDisplayed),
            RecruiterSeeRequirements()
          ],
        ),
      ),
    );
  }

  void goToStartPage() {
    Navigator.pop(context);
  }

  void filterSearchResults (String query){
    List<Candidate> dummyCandidateList = List();
    dummyCandidateList.addAll(candidateList);

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
        /* for (Candidate candidate in candidateListToBeDisplayed){
          print(candidate.name); */
        dummy = true;
      });
    } else{
      setState(() {
        candidateListToBeDisplayed.clear();
        candidateListToBeDisplayed.addAll(candidateList);
        dummy = false;
      });
    } 
  }
}

