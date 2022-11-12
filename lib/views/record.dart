import 'package:explode/services/crud/records_service.dart';
import 'package:flutter/material.dart';

class Record extends StatefulWidget {
  const Record({
    super.key,
    required this.correctAnswers,
    required this.operators,
    required this.difficulty,
    required this.time,
  });

  final int correctAnswers;
  final List<String> operators;
  final String difficulty;
  final int time;

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  late int _correctAnswers;
  late List<String> _operators;
  late String _difficulty;
  late int _time;

  @override
  void initState() {
    print(_correctAnswers);
    print(widget.correctAnswers);
    _correctAnswers = widget.correctAnswers;
    _operators = widget.operators;
    _difficulty = widget.difficulty;
    _time = widget.time;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
