import 'package:interview_master/models/user.dart';

class Requirement {
  String id;
  String primarySkill;
  List<dynamic> secondarySkills;
  List<dynamic> softSkills;
  String experienceLevel;
  String projectName;
  String customerName;
  String owner;
  
  Requirement({this.id, this.primarySkill, this.secondarySkills, this.softSkills, this.experienceLevel, this.projectName, this.customerName, this.owner});

}