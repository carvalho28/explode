import 'package:explode/constants/general.dart';
import 'package:flutter/material.dart';

// widget that shows for a second a check or a cross depending on the answer
class VerificationIcon extends StatefulWidget {
  const VerificationIcon({super.key, required this.correct});

  final bool correct;

  @override
  State<VerificationIcon> createState() => _VerificationIconState();
}

class _VerificationIconState extends State<VerificationIcon> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        // after a second, remove the widget
        Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // wrap the container to not occupy the whole screen
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: widget.correct ? correctColor : incorrectColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Icon(
            widget.correct ? Icons.check : Icons.close,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
    // return Container(
    //   width: 10,
    //   height: 10,
    //   decoration: BoxDecoration(
    //     color: widget.correct ? correctColor : incorrectColor,
    //     borderRadius: BorderRadius.circular(50),
    //   ),
    //   child: Center(
    //     child: Icon(
    //       widget.correct ? Icons.check : Icons.close,
    //       color: Colors.white,
    //       size: 50,
    //     ),
    //   ),
    // );
  }
}
