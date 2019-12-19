import 'package:flutter/material.dart';
import 'dart:async';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/screens/recruiterseecandidates.dart';
import 'package:interview_master/screens/recruiterseerequirements.dart';

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
  int count = 0;
  List<Requirement> requirementList;

  Icon searchIcon = Icon(Icons.search);
  Widget searchBar = Text('Interview Helper');

  TextEditingController _controller = TextEditingController();
  bool _isSearching;
  String _searchText = "";
  List searchResult = List();

  RecruiterSeeCandidatesAndRequirementsState(){
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  void initState(){
    super.initState();
    _isSearching = false;
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // goToPreviousPage();
                if (this.searchIcon.icon == Icons.search){
                  goToStartPage();
                }else{
                  this.searchIcon = Icon(Icons.search);
                  this.searchBar = Text('Interview Helper');
                }

              }),
          title: this.searchBar,
          bottom: TabBar(
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
                setState(() {
                  if (this.searchIcon.icon == Icons.search) {
                    this.searchIcon = Icon(Icons.close);
                    this.searchBar = TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.go,
                      style: TextStyle(color: Colors.white, fontSize: 18),

                    );
                  } else {
                    this.searchIcon = Icon(Icons.search);
                    this.searchBar = Text('Interview Helper');
                  }
                });
              },
            )
          ],
        ),


        body: TabBarView(
          children: <Widget>[
            RecruiterSeeCandidatesByRequirement(),
            RecruiterSeeRequirements()
          ],
        ),
      ),
    );
  }

  void goToStartPage() {
    Navigator.pop(context);
  }
}