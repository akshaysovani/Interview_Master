import 'package:flutter/material.dart';
import 'package:interview_master/models/round.dart';
import 'package:interview_master/screens/interviewerseeroundsofcandidate.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/candidate.dart';
import 'package:interview_master/services/auth.dart';
import 'package:provider/provider.dart';


class InterviewerSeeCandidates extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InterviewerSeeCandidatesState();
  }
}

class InterviewerSeeCandidatesState extends State<InterviewerSeeCandidates> {
  final AuthService _authService = AuthService();
  //int count = 0;
  List<Candidate> candidateList;
  List<Candidate> candidateListToBeDisplayed;
  bool dummy = false;

  Icon searchIcon = Icon(Icons.search);
  Widget searchBar = Text('Candidates');

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

    return Scaffold(
      appBar: AppBar(
        title: this.searchBar,
        actions: <Widget>[
          IconButton(  
              icon: this.searchIcon,
              onPressed: () {
                setState(() {
                  if (this.searchIcon.icon == Icons.search) {
                    this.searchIcon = Icon(Icons.close);
                    this.searchBar = TextField(
                      autofocus: true,
                      onChanged: (value){
                        filterSearchResults(value);    
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
              }
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
      body: getListView(),
  
    );
  }

  void filterSearchResults(String query){
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

  ListView getListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.title;
    TextStyle subTitleStyle = Theme.of(context).textTheme.subtitle;
    return ListView.builder(
        itemCount: this.candidateListToBeDisplayed.length,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                this.candidateListToBeDisplayed[position].name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[900]),
              ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                this.candidateListToBeDisplayed[position].experienceLevel,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500
                ),
              ),
              ),
              
              
              trailing: SizedBox(
                width: 150,
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: getText(this.candidateListToBeDisplayed[position])
                )
                ,
              ),
              onTap: (){
                dummy = false;
                this.searchIcon = Icon(Icons.search);
                this.searchBar = Text('Candidates');
                goToInterviewerSeeRoundsOfCandidate(this.candidateListToBeDisplayed[position]);
              },
            ),
          );
        });
  }

  Text getText(Candidate candidate){
    int passCounter = 0;
    if (candidate.roundsInfo.last.roundNumber == '0'){
      return Text('',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,
                      ));
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

  void goToStartPage(){
    Navigator.pop(context);
  }

  void goToInterviewerSeeRoundsOfCandidate(Candidate candidate){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return InterviewerSeeRoundsOfCandidate(candidate);
    }));
  }
}
