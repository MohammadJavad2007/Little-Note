import 'package:flutter/material.dart';
import 'package:notes/Screen/ScreenNotes.dart';

void main() {
  runApp(const Notes());
}

class Notes extends StatelessWidget {
  const Notes({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: ScreenNotes(),
    );
  }
}

