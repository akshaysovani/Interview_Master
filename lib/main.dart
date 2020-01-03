import 'package:flutter/material.dart';
import 'package:interview_master/models/employee.dart';
import 'package:interview_master/models/primarySkill.dart';
import 'package:interview_master/models/project.dart';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/secondarySkill.dart';
import 'package:interview_master/models/softSkill.dart';
import 'package:interview_master/models/user.dart';
import 'package:interview_master/screens/wrapper.dart';
import 'package:interview_master/services/auth.dart';
import 'package:interview_master/services/database.dart';
import 'package:provider/provider.dart';

import 'models/candidate.dart';

void main() {
  runApp(InterviewApp());
}

class InterviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: AuthService().user),
        StreamProvider<List<Requirement>>.value(
            value: DatabaseService().requirements),
        StreamProvider<List<Candidate>>.value(
            value: DatabaseService().candidates),
        StreamProvider<List<PrimarySkill>>.value(
            value: DatabaseService().primarySkillStream),
        StreamProvider<List<SecondarySkill>>.value(
            value: DatabaseService().secondarySkillStream),
        StreamProvider<List<SoftSkill>>.value(
            value: DatabaseService().softSkillStream),
        StreamProvider<List<Project>>.value(
            value: DatabaseService().projectStream),
        StreamProvider<List<Employee>>.value(
            value: DatabaseService().employees),
      ],
      child: MaterialApp(
          theme: ThemeData(
              primaryColor: Colors.blue[900],
              accentColor: Colors.grey[200],
              fontFamily: 'Open Sans'
              ),
          debugShowCheckedModeBanner: false,
          title: 'Interview Helper',
          home: Wrapper()
          ),
    );
  }
}
