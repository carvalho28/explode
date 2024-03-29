import 'package:explode/constants/general.dart';
import 'package:flutter/material.dart';

// widget that shows for a second a check or a cross depending on the answer
// class VerificationIcon extends StatefulWidget {
//   const VerificationIcon({super.key, required this.correct});

//   final bool correct;

//   @override
//   State<VerificationIcon> createState() => _VerificationIconState();
// }

// class _VerificationIconState extends State<VerificationIcon> {
//   @override
//   void initState() {
//     super.initState();
//     Future<void>.delayed(const Duration(milliseconds: 300), () {
//       if (mounted) {
//         setState(() {
//           Navigator.of(context).pop();
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: 100,
//         height: 100,
//         decoration: BoxDecoration(
//           color: widget.correct ? correctColor : incorrectColor,
//           borderRadius: BorderRadius.circular(50),
//         ),
//         child: Center(
//           child: Icon(
//             widget.correct ? Icons.check : Icons.close,
//             color: Colors.white,
//             size: 50,
//           ),
//         ),
//       ),
//     );
//   }
// }

// verification icon as a stateless widget
class VerificationIcon extends StatelessWidget {
  const VerificationIcon({
    super.key,
    required this.correct,
  });

  final bool correct;

  // take a second to show the icon and then remove it
  @override
  Widget build(BuildContext context) {
    Future<void>.delayed(const Duration(milliseconds: 300), () {
      Navigator.of(context).pop();
    });
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: correct
              ? correctColor.withOpacity(0.8)
              : incorrectColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Icon(
            correct ? Icons.check : Icons.close,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
