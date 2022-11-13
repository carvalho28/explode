import 'package:explode/constants/general.dart';
import 'package:explode/models/record_model.dart';
import 'package:explode/providers/answers_provider.dart';
import 'package:explode/providers/time_ender_provider.dart';
import 'package:explode/services/crud/records_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late int _correctAnswers = 0;
  late String _operators;
  late String _difficulty;
  late int _time;

  late RecordModel? _record;

  Future refreshRecord() async {
    _record = await RecordsService.instance.readRecord(
      _operators,
      _difficulty,
      _time,
    );
    if (_record == null) {
      _record = const RecordModel(
        correctAnswers: -1,
        operators: '',
        difficulty: '-1',
        time: -1,
      );
    } else {
      _record = _record!.copy(
        correctAnswers: _correctAnswers,
        operators: _operators,
        difficulty: _difficulty,
        time: _time,
      );
    }
  }

  Future saveRecord() async {
    if (_record?.correctAnswers == -1) {
      await RecordsService.instance.create(
        RecordModel(
            correctAnswers: _correctAnswers,
            difficulty: _difficulty,
            operators: _operators,
            time: _time),
      );
    } else {
      if (_correctAnswers > _record!.correctAnswers) {
        await RecordsService.instance.update(
          _record!.copy(correctAnswers: _correctAnswers),
        );
      }
    }
  }

  // function to print all the records
  Future printRecords() async {
    List<RecordModel> records = await RecordsService.instance.readAllRecords();
    for (RecordModel record in records) {
      print(record.toJson());
    }
  }

  @override
  void initState() {
    print(_correctAnswers);
    print(widget.correctAnswers);
    _correctAnswers = widget.correctAnswers;
    _operators = widget.operators.join();
    _difficulty = widget.difficulty;
    _time = widget.time;
    refreshRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Records: ');
    printRecords();
    // print(_record!.toJson())

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: refreshRecord(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(seconds: 3),
                    builder: (context, double value, child) {
                      return Transform.scale(
                        scale: value,
                        child: child,
                      );
                    },
                    child: const Text(
                      'Game\nOver',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontFamily: fontGameOver,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // print game mode
                  // if new record is set, display it and say how many points were scored
                  if (_record?.correctAnswers == -1 ||
                      _correctAnswers > _record!.correctAnswers)
                    Column(
                      children: const [
                        //  trophy icon
                        Icon(
                          Icons.emoji_events,
                          color: Colors.white,
                          size: 80,
                        ),
                        Text(
                          'New Record!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),
                  // if (_record?.correctAnswers != -1 &&
                  //     _correctAnswers <= _record!.correctAnswers)
                  //   Text(
                  //     'Your record is still: ${_record!.correctAnswers}',
                  //     style: const TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 30,
                  //     ),
                  //   ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      const Text(
                        'Score:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        '$_correctAnswers',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 20,
                      ),
                      // add shadow to the button
                      elevation: 15,
                    ),
                    onPressed: () {
                      saveRecord();
                      Provider.of<EndTimer>(context, listen: false)
                          .resetEndTimer();
                      Provider.of<Answers>(context, listen: false)
                          .resetCorrect();
                      Provider.of<Answers>(context, listen: false).resetWrong();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/main-menu',
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Back to Main Menu',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
