import 'package:firebase_auth/firebase_auth.dart';
import 'package:interview_master/models/user.dart';
import 'package:interview_master/models/userwithrole.dart';
import 'package:interview_master/services/database.dart';


class AuthService{


final FirebaseAuth _auth = FirebaseAuth.instance;

User getUserFromFirebaseUser(FirebaseUser user){
  return user!=null ? User(id: user.uid) : null;
}

UserWithRole getUserWithRoleFromFirebaseUser(FirebaseUser user, String role){
  return user!=null ? UserWithRole(user.uid,role) : null;
}

//Stream of Firebaseuser on change of auth state   //User if signing in else null if user signs out.  
Stream<UserWithRole> get userWithRole{
  return _auth.onAuthStateChanged
  .map((FirebaseUser user){
      //get role from database
      if (user != null){
      print('user is : '+ user.toString());
      //String role = DatabaseService(user.uid).getRoleForThisUser();
      DatabaseService(user.uid).getRoleForThisUser();
      //Future<String> role = DatabaseService(user.uid).getRoleForThisUser();
      //print('role is : '+ role.toString());
      //print('role is ...'+ role);
      //String role = getRoleofUser();
      String role = 'Role';
      return getUserWithRoleFromFirebaseUser(user,role.toString());
      }
      return null;
  });
}

//anon
Future signInAnon() async{
  try{
      AuthResult result = await _auth.signInAnonymously();
      return getUserFromFirebaseUser(result.user);
  }catch(e){
    print(e.toString());
    return null;
  }      
}


//sign in
Future signInWithEmailAndPassword(String email, String password) async{
  try{
     AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password); 
     return getUserFromFirebaseUser(result.user);
  }catch(e){
    print(e.toString());
    return null;
  }
}


//register with email and password
Future registerWithEmailAndPassword(String fullName, String role, String email, String password) async{
  try{
     AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password); 
     //Create a new document for the registered used
     await DatabaseService(result.user.uid).updateUserCollection(fullName, role);
     return getUserFromFirebaseUser(result.user);
  }catch(e){
    print(e.toString());
    return null;
  }
}

//sign out
Future signOut() async{
try{
  return await _auth.signOut();
}catch(e){
  print(e.toString());
  return null;
}
}

}