import 'package:flutter/material.dart';
class DefaultScreen extends StatelessWidget {
  const DefaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Default",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: const Center(
        child: Text("NO DATA",style: TextStyle(
          fontSize: 24,
          fontFamily: 'MainFont',
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
