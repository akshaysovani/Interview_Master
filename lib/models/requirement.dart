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
  
  //String _date_updated;

  //int _priority;

  //  Requirement(this._title, this._no_of_vacancies, this._date_updated);
  Requirement({this.id, this.primarySkill, this.secondarySkills, this.softSkills, this.experienceLevel, this.projectName, this.customerName, this.owner});
  // Note.withID(this._id, this._title, this._date, this._priority, // withID is the name of the constructor.
  //   [this._description]);

  /* int get id => id;

  String get primarySkill => _primarySkill;

  List<String> get secondarySkills => _secondarySkills;

  String get experienceLevel => _experienceLevel;

  String get projectName => _projectName;

  String get customerName => _customerName;

 // String get date_updated => _date_updated;

  //int get priority => _priority;

  set id(int newId) {
    this._id = newId;
  }

  set primarySkill(String newPrimarySkill) {
    this._primarySkill = newPrimarySkill;
  }

  set secondarySkills(List<String> newSecondarySkills) {
    this._secondarySkills = newSecondarySkills;
  }

  set experienceLevel(String newExperienceLevel) {
    this._experienceLevel = newExperienceLevel;
  }

  set projectName(String newProjectName) {
    this._projectName = newProjectName;
  }

  set customerName(String newCustomerName) {
    this._customerName = newCustomerName;
  } */
  /*set date_updated(String newDate) {
    this._date_updated = newDate;
  }*/

/*
  set priority(int newPriority) {
    if (newPriority == 1 || newPriority == 2) {
      this._priority = newPriority;
    }
  }
*/
  // Requirement to Map object
  /* Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['primarySkill'] = primarySkill;
   // map['no_of_vacancies'] = _no_of_vacancies;
    //map['date_updated'] = _date_updated;
    //map['priority'] = _priority;
    return map;
  }

  //Map to Note object
  Requirement.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.primarySkill = map['primarySkill'];
    //this._no_of_vacancies = map['no_of_vacancies'];
    //this._date_updated = map['date_updated'];
    //this._priority = map['priority'];
  } */
}