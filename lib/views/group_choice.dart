import 'package:explode/constants/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GroupChoice extends StatefulWidget {
  const GroupChoice({
    super.key,
    required this.playersNames,
  });

  final List<String> playersNames;

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
