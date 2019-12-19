class Employee{
  int _employeeId;
  String _employeeName;
  String _employeeRole;

  Employee(this._employeeId, this._employeeName, this._employeeRole);

  //String get employeeName => _employeeName;
  String get employeeName => _employeeName;
  String get employeeRole => _employeeRole;

  set employeeName(String newEmployeeName) {
    this._employeeName = newEmployeeName;
  }

  set employeeRole(String newEmployeeRole) {
    this._employeeRole = newEmployeeRole;
  }
}