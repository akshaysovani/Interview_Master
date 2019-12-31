import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:interview_master/models/candidate.dart';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/round.dart';
import 'package:interview_master/models/user.dart';
import 'package:interview_master/models/userwithname.dart';


class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('user');
  final CollectionReference requirementCollection = Firestore.instance.collection('requirement');
  final CollectionReference candidateCollection = Firestore.instance.collection('candidate');

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
}