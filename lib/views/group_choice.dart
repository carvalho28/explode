import 'package:explode/constants/general.dart';
import 'package:flutter/material.dart';

class GroupChoice extends StatefulWidget {
  const GroupChoice({super.key});

  @override
  State<GroupChoice> createState() => _GroupChoiceState();
}

class _GroupChoiceState extends State<GroupChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(children: [
          Text('Group Choice'),
        ]),
      ),
    );
  }
}
