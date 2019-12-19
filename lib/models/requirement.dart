class Requirement {
  int _id;
  String _title;
  String _experience_level;
  String _project_name;
//  String _date_updated;

  //int _priority;

//  Requirement(this._title, this._no_of_vacancies, this._date_updated);
  Requirement(this._id, this._title, this._experience_level, this._project_name);
  // Note.withID(this._id, this._title, this._date, this._priority, // withID is the name of the constructor.
  //   [this._description]);

  int get id => _id;

  String get title => _title;

  String get experience_level => _experience_level;

  String get project_name => _project_name;

 // String get date_updated => _date_updated;

  //int get priority => _priority;

  set id(int newId) {
    this._id = newId;
  }

  set title(String newTitle) {
    this._title = newTitle;
  }

  set no_of_vacancies(String newExperienceLevel) {
    this._experience_level = newExperienceLevel;
  }

  set project_name(String newProjectName) {
    this._project_name = newProjectName;
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
    map['title'] = _title;
   // map['no_of_vacancies'] = _no_of_vacancies;
    //map['date_updated'] = _date_updated;
    //map['priority'] = _priority;
    return map;
  }

  //Map to Note object
  Requirement.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    //this._no_of_vacancies = map['no_of_vacancies'];
    //this._date_updated = map['date_updated'];
    //this._priority = map['priority'];
  }
}