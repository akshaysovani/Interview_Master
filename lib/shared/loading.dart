import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
      color: Colors.white,
      child: Center(
        child: SpinKitWave(color: Colors.blue[900], size: 50,),
        ),
    ),
    );
  }
}