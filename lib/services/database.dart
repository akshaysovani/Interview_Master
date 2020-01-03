import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:interview_master/models/candidate.dart';
import 'package:interview_master/models/employee.dart';
import 'package:interview_master/models/primarySkill.dart';
import 'package:interview_master/models/project.dart';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/round.dart';
import 'package:interview_master/models/secondarySkill.dart';
import 'package:interview_master/models/softSkill.dart';
import 'package:interview_master/models/user.dart';
import 'package:interview_master/models/userwithname.dart';
import 'package:flutter/material.dart';
import 'package:interview_master/screens/authenticate/newuserregister.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('user');
  final CollectionReference requirementCollection = Firestore.instance.collection('requirement');
  final CollectionReference candidateCollection = Firestore.instance.collection('candidate');
  final CollectionReference primarySkillsCollection = Firestore.instance.collection('primarySkills');
  final CollectionReference secondarySkillsCollection = Firestore.instance.collection('secondarySkills');
  final CollectionReference softSkillsCollection = Firestore.instance.collection('softSkills');
  final CollectionReference projectCollection = Firestore.instance.collection('project');
  //final CollectionReference employeeCollection = Firestore.instance.collection('project');
  Future updateUserCollection(String fullName, String role) async{
      return await userCollection.document(uid).setData({
        'id': uid,
        'fullName': fullName,
        'role': role
      });
  }

  //Get Name of User 
   Future<String> getName(User user) async{
    String name = '';
    //print('In getRole start');
    //print(user);
    if (user != null){
      //print('In getRole start');
      var userQuery = await Firestore.instance.collection('user').where('id', isEqualTo: user.id).getDocuments().then((data){ 
          if (data.documents.length > 0){
                    //print('In getRole');
                    name = data.documents[0].data['fullName'];
                    //print(role);
         
          }});
      //print('userQuery:'+userQuery.toString());
      //print('Role:'+role);
    }
      return name;
  }  

  //Add new requirement
  Future addNewRequirement(Requirement requirement, User user) async{
      String name = await getName(user);
      print(name);
      final docref = await requirementCollection.add({
        //'id': requirement.id,
        'primarySkill': requirement.primarySkill,
        'secondarySkills': requirement.secondarySkills,
        'softSkills': requirement.softSkills,
        'experienceLevel': requirement.experienceLevel,
        'projectName': requirement.projectName,
        //'customerName': requirement.customerName,
        'owner': name,
      });
      String docId = docref.documentID;
      print('new Id is: '+ docId);
      final _docRef = await requirementCollection.document(docId).setData({
         'id': docId,    
      }, merge: true);
    } 

  //Edit current requirement
  Future editCurrentRequirement(Requirement requirement, User user) async{
      String name = await getName(user);
      print(name);
      final _docRef = await requirementCollection.document(requirement.id).setData({
        'primarySkill': requirement.primarySkill,
        'secondarySkills': requirement.secondarySkills,
        'softSkills': requirement.softSkills,
        'experienceLevel': requirement.experienceLevel,
        'projectName': requirement.projectName,
        //'customerName': requirement.customerName,
        'owner': name,
      }, merge: true);
  }

  //Delete current requirement
  Future deleteCurrentRequirement(Requirement requirement) async{
    final result = await requirementCollection.document(requirement.id).delete();
  }

  //Get list of Requirement objects from snapshot
  List<Requirement> getRequirementList(QuerySnapshot querySnapshot){
    return querySnapshot.documents.map((doc){
      return Requirement(
        id: doc.data['id'] ?? '',
        primarySkill: doc.data['primarySkill'] ?? '',
        secondarySkills: doc.data['secondarySkills'] ?? [],
        softSkills: doc.data['softSkills'] ?? '',
        experienceLevel: doc.data['experienceLevel'] ?? '',
        projectName: doc.data['projectName'] ?? '',
        owner: doc.data['owner'] ?? ''
        //customerName: doc.data['customerName'] ?? '',        
      );
    }).toList();
  }

  Stream<List<Requirement>> get requirements{
      return requirementCollection.snapshots()
      .map(getRequirementList);
  }

    /* List<Round> getRoundInfo(List<Map<String, dynamic>> listOfRoundMapObjects){
      List<Round> roundList = List();
      for (Map<String, dynamic> map in listOfRoundMapObjects){
        String roundNumber = map['roundNumber'];   
        String status = map['status'];   
        String interviewerName = map['interviewerName'];
        String feedback = map['feedback'];
        
        Round round = Round(roundNumber: roundNumber, status: status, interviewerName: interviewerName, feedback: feedback);
        roundList.add(round);
      }
      return roundList;    
    } */

    List<Round> getRoundInfo(List<dynamic> listOfRoundDynamicObjects){
      List<Round> roundList = List();
      listOfRoundDynamicObjects.forEach((map){
        String roundNumber = map['roundNumber'];   
        String status = map['status'];   
        String interviewerName = map['interviewerName'];
        String feedback = map['feedback'];
        
        Round round = Round(roundNumber: roundNumber, status: status, interviewerName: interviewerName, feedback: feedback);
        roundList.add(round);
      });
      return roundList; 
    }

    List<Candidate> getCandidateList(QuerySnapshot querySnapshot){  
    return querySnapshot.documents.map((doc){
      return Candidate(
        id: doc.data['id'] ?? '',
        name: doc.data['name'] ?? '',
        primarySkill: doc.data['primarySkill'] ?? '',
        secondarySkills: doc.data['secondarySkills'] ?? [],// Problematic  want to insert List<String> instead of List<dynamic>
        softSkills: doc.data['softSkills'] ?? '',
        experienceLevel: doc.data['experienceLevel'] ?? '',
        projectName: doc.data['projectName'] ?? '',
        roundsInfo: getRoundInfo(doc.data['roundsInfo']) ?? [],
      );
    }).toList();
  }

  Stream<List<Candidate>> get candidates{
      return candidateCollection.snapshots()
      .map(getCandidateList);
  }

  List<PrimarySkill> getPrimarySkillsList(QuerySnapshot querySnapshot){  
    return querySnapshot.documents.map((doc){
      return PrimarySkill(
        skillName: doc.data['skillName'] ?? '',
      );
    }).toList();
  }

  Stream<List<PrimarySkill>> get primarySkillStream{
      return primarySkillsCollection.snapshots()
      .map(getPrimarySkillsList);
  }


  List<SecondarySkill> getSecondarySkillsList(QuerySnapshot querySnapshot){  
    return querySnapshot.documents.map((doc){
      return SecondarySkill(
        skillName: doc.data['skillName'] ?? '',
      );
    }).toList();
  }

  Stream<List<SecondarySkill>> get secondarySkillStream{
      return secondarySkillsCollection.snapshots()
      .map(getSecondarySkillsList);
  }


  List<SoftSkill> getSoftSkillsList(QuerySnapshot querySnapshot){  
    return querySnapshot.documents.map((doc){
      return SoftSkill(
        skillName: doc.data['skillName'] ?? '',
      );
    }).toList();
  }

  Stream<List<SoftSkill>> get softSkillStream{
      return softSkillsCollection.snapshots()
      .map(getSoftSkillsList);
  }

  List<Project> getProjectsList(QuerySnapshot querySnapshot){  
    return querySnapshot.documents.map((doc){
      return Project(
        name: doc.data['name'] ?? '',
      );
    }).toList();
  }


  Stream<List<Project>> get projectStream{
      return projectCollection.snapshots()
      .map(getProjectsList);
  }

 
  Future addNewRound(Round incomingRound, Candidate candidate) async{
    List<Map<String, dynamic>> listOfRounds = List();
    Map<String, dynamic> map = Map();
    map['roundNumber'] = incomingRound.roundNumber;
    map['status'] = incomingRound.status;
    map['interviewerName'] = incomingRound.interviewerName; 
    map['feedback']= incomingRound.feedback;

    listOfRounds.add(map);

    final _docRef = await candidateCollection.document(candidate.id).setData({
        'roundsInfo': FieldValue.arrayUnion(listOfRounds)
    }, merge: true);
  }



  //Add new Candidate
  Future addNewCandidate(Candidate candidate) async{
      List<Map<String, dynamic>> listOfRounds = candidate.roundsInfo
            .map((round) => {
              'roundNumber': round.roundNumber,
              'status': round.status,
              'interviewerName': round.interviewerName, 
              'feedback': round.feedback 
            })
            .toList(); 
      
      final docref = await candidateCollection.add({
        //'id': requirement.id,
        'name': candidate.name,
        'primarySkill': candidate.primarySkill,
        'secondarySkills': candidate.secondarySkills,
        'softSkills': candidate.softSkills,
        'experienceLevel': candidate.experienceLevel,
        'projectName': candidate.projectName,
        'roundsInfo': FieldValue.arrayUnion(listOfRounds)
      });

      String docId = docref.documentID;
      print('new Id is: '+ docId);
      final _docRef = await candidateCollection.document(docId).setData({
        'id': docId,    
      }, merge: true);
    }


  //Edit current candidate
  Future editCurrentCandidate(Candidate candidate) async{
      final _docRef = await  candidateCollection.document(candidate.id).setData({
        'name': candidate.name,
        'primarySkill': candidate.primarySkill,
        'secondarySkills': candidate.secondarySkills,
        'softSkills': candidate.softSkills,
        'experienceLevel': candidate.experienceLevel,
        'projectName': candidate.projectName,
      }, merge: true);
  }

  //delete current candidate
  void deleteCurrentCandidate(Candidate candidate) async{
    final result = await candidateCollection.document(candidate.id).delete();   
  }




  List<Employee> getEmployeeList(QuerySnapshot querySnapshot){  
    return querySnapshot.documents.map((doc){
      return Employee(
        id: doc.data['id'] ?? '',
        name: doc.data['fullName'] ?? '',
        role: doc.data['role'] ?? '',
      );
    }).toList();
  }

  Stream<List<Employee>> get employees{
      return userCollection.snapshots()
      .map(getEmployeeList);
  }

  


  //Add new Employee
  Future addNewEmployee(Employee employee) async{
      final docref = await userCollection.add({
        'fullName': employee.name,
        'role': employee.role
      });

      String docId = docref.documentID;
      print('new Id is: '+ docId);
      final _docRef = await userCollection.document(docId).setData({
        'id': docId,    
      }, merge: true);
    }

    //Edit Current Employee
    Future adminEditCurrentEmployee(Employee employee) async{
      final _docRef = await userCollection.document(employee.id).setData({
        'fullName': employee.name,
        'role': employee.role
      }, merge: true);
    }

    //Delete Current Employee
    Future deleteCurrentEmployee(Employee employee) async{
    final result = await userCollection.document(employee.id).delete();
    }
}