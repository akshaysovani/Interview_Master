import 'package:flutter/material.dart';
import 'package:interview_master/models/userwithrole.dart';
import 'package:interview_master/screens/authenticate/authenticate.dart';
import 'package:interview_master/screens/startpage.dart';
import 'package:provider/provider.dart';
//import 'package:interview_master/models/user.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserWithRole>(context);
    if (user != null){
        print('here');
        print(user);
        return Authenticate();
    }else{
        //print(user.role);
        return StartPage();  
    }
    

/* 
    if (user == null){
      /* 
      try{
        print('in if');
        //print(user.role);  
      
      }catch(e){
          print(e.toString());
      } */
    
    }
     else{
       /*
      try{
        print('in else');
        //print(user.role);  
        
      }catch(e){
        print(e.toString());
      }*/
      return StartPage();  
    } 

    //return either startpage (Ultimately home screens for each role) or auth
  } */
}
}