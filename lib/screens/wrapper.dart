import 'package:flutter/material.dart';
import 'package:interview_master/screens/authenticate/authenticate.dart';
import 'package:interview_master/screens/startpage.dart';
import 'package:provider/provider.dart';
import 'package:interview_master/models/user.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);  

    if (user == null){
      return Authenticate();
    }
    else{
      return StartPage();  
    }

    //return either startpage (Ultimately home screens for each role) or auth
  }
}