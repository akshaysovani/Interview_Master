class Candidate {
  int _id;
  String _name;
  String _experience_level;
  String _skill;
//  String _date_updated;

  //int _priority;

//  Requirement(this._title, this._no_of_vacancies, this._date_updated);
  Candidate(this._id, this._name, this._experience_level, this._skill);
  // Note.withID(this._id, this._title, this._date, this._priority, // withID is the name of the constructor.
  //   [this._description]);

  int get id => _id;

  String get name => _name;

  String get experience_level => _experience_level;

  String get skill => _skill;

  // String get date_updated => _date_updated;

  //int get priority => _priority;

  set id(int newId) {
    this._id = newId;
  }

  set name(String newName) {
    this._name = newName;
  }

  set experience(String newExperienceLevel) {
    this._experience_level = newExperienceLevel;
  }

  set skill(String newSkill) {
    this._skill = newSkill;
  }
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
  // Note to Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['experience_level'] = _experience_level;
    map['skill'] = _skill;
    //map['date_updated'] = _date_updated;
    //map['priority'] = _priority;
    return map;
  }

  //Map to Note object
  Candidate.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._experience_level = map['experience_level'];
    this._skill = map['skill'];
    //this._date_updated = map['date_updated'];
    //this._priority = map['priority'];
  }
}