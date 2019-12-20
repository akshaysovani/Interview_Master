import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService(this.uid);

  final CollectionReference userCollection = Firestore.instance.collection('user');
  
  Future updateUserCollection(String fullName, String role) async{
      return await userCollection.document(uid).setData({
        'fullName': fullName,
        'role': role
      });
  }
}