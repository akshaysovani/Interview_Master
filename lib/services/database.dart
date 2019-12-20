
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:interview_master/models/userwithrole.dart';

class DatabaseService {
  final String uid;
  DatabaseService(this.uid);

  final CollectionReference userCollection = Firestore.instance.collection('user');
  
  Future updateUserCollection(String fullName, String role) async{
      return await userCollection.document(uid).setData({
        'id': uid,
        'fullName': fullName,
        'role': role
      });
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

void getRoleForThisUser() async {
  Firestore.instance.collection('user').getDocuments().then((val){
    if(val.documents.length > 0){
        print(val.documents[0].data["role"]);
    }
    else{
        print("Not Found");
    }
  });

}
 
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
