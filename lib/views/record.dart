import 'package:explode/constants/general.dart';
import 'package:explode/providers/time_ender_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Record extends StatefulWidget {
  const Record({
    super.key,
    required this.correctAnswers,
  });

  final int correctAnswers;

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  late int _correctAnswers;
  late SharedPreferences _prefs;

  @override
  void initState() {
    _correctAnswers = widget.correctAnswers;
    Provider.of<EndTimer>(context, listen: false).changeEndTimer(false);
    super.initState();
  }

  // save the record in the shared preferences
  Future<void> saveRecord() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getInt('record') == null) {
      _prefs.setInt('record', _correctAnswers);
    } else if (_prefs.getInt('record')! < _correctAnswers) {
      _prefs.setInt('record', _correctAnswers);
    }
  }

  // get the record from the shared preferences
  Future<int> getRecord() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getInt('record') == null) {
      return -1;
    } else {
      return _prefs.getInt('record')!;
    }
  }

  // widget to present the new record
  Widget newRecord(int record) {
    if (record == -1) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Text(
          'New record: $_correctAnswers',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      );
    } else if (record < _correctAnswers) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Text(
          'New record: $_correctAnswers',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Container(
        // record not beaten, present the actual record and the actual score
        margin: const EdgeInsets.only(top: 20),
        child: Text(
          'Record: $record\nScore: $_correctAnswers',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<int> recordSaved = getRecord();
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Game Over',
              style: TextStyle(
                color: Colors.white,
                fontSize: 100,
                fontFamily: fontTitle,
              ),
            ),
            FutureBuilder<int>(
              future: recordSaved,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return newRecord(snapshot.data!);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
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
                  // _prefs.clear();
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
            ),
          ],
        ),
      ),
    );
  }
}
