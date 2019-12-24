import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:interview_master/models/requirement.dart';
import 'package:interview_master/models/user.dart';
import 'package:interview_master/models/userwithrole.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('user');
  final CollectionReference requirementCollection = Firestore.instance.collection('requirement');

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


  //call this from add requirement of HM
  Future updateRequirementCollection(Requirement requirement, User user) async{
      String name = await getName(user);
      print(name);
      return await requirementCollection.document(uid).setData({
        //'id': requirement.id,
        'primarySkill': requirement.primarySkill,
        'secondarySkills': requirement.secondarySkills,
        'softSkills': requirement.softSkills,
        'experienceLevel': requirement.experienceLevel,
        'projectName': requirement.projectName,
        //'customerName': requirement.customerName,
        'owner': name,
      });
  } 

  //Get list of Requirement objects from snapshot
  List<Requirement> getRequirementList(QuerySnapshot querySnapshot){
    return querySnapshot.documents.map((doc){
      return Requirement(
        primarySkill: doc.data['primarySkill'] ?? '',
        //secondarySkills: doc.data['secondarySkills'] ?? [],// Problematic  want to insert List<String> instead of List<dynamic>
        //softSkills: doc.data['softSkills'] ?? '',
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




/* 
  List<UserWithRole> getAllUsersWithRoles(){
      return userCollection.snapshots().map(_userListFromSnapshot);
  }

  List<UserWithRole> _userListFromSnapshot(QuerySnapshot querySnapshot){
    return querySnapshot.documents.map((doc){
        return UserWithRole(
          id: doc.data['']      
        );
    });
  }
 */

/*   getData() async {
  return await Firestore.instance.collection('user').getDocuments();
  } */


 
 /*  void getRoleForThisUser() async {
      DocumentReference document = await Firestore.instance.collection('user').document(uid);
      //document.
      
      print('hey' + documentReference.documentID);
      //String a = documentReference.get();
    }
     */


/*     FirebaseAuth.instance.currentUser().then((user){
    Firestore.instance
    .collection('/user')
    .where('id', isEqualTo: uid)               //user --> Current logged in user  
    .getDocuments()
    .then((docs){
       if (docs.documents[0].exists){
         print('doc exists');
         return docs.documents[0].data['role'];
       } 
    });
    });
    return null; */


  }

  /* Stream<QuerySnapshot> get users{
    return userCollection.snapshots();
  } */
