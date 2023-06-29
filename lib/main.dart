import 'package:flutter/material.dart';

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
      home: Center(),
    );
  }
}


class ScreenNotes extends StatefulWidget {
  const ScreenNotes({super.key});

  @override
  State<ScreenNotes> createState() => _ScreenNotesState();
}

class _ScreenNotesState extends State<ScreenNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
    );
  }
}