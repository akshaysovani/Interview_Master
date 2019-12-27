class Round {
  String roundNumber;
  String status;
  String interviewerName;
  String feedback;

//  String _date_updated;

  //int _priority;

//  Requirement(this._title, this._no_of_vacancies, this._date_updated);
  Round({this.roundNumber, this.status, this.interviewerName,
      this.feedback});

  // Note.withID(this._id, this._title, this._date, this._priority, // withID is the name of the constructor.
  //   [this._description]);
/* 
  int get round_number => _round_number;

  String get status => _status;

  String get interviewer_name => _interviewer_name;

  String get feedback => _feedback;

  // String get date_updated => _date_updated;

  //int get priority => _priority;

  set round_number(int newRoundNumber) {
    this._round_number = newRoundNumber;
  }

  set status(String newStatus) {
    this._status = newStatus;
  }

  set interviewer_name(String newInterviewerName) {
    this._interviewer_name = newInterviewerName;
  }

  set feedback(String newFeedback) {
    this._feedback = newFeedback;
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


/*
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
}*/
}