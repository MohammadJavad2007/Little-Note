import 'package:flutter/material.dart';

import 'package:notes/models/person.dart';
import 'package:notes/utils/update_person_form.dart';

class ScreenUpdateNotes extends StatefulWidget {
  final int index;
  final Person person;

  const ScreenUpdateNotes({
    required this.index,
    required this.person,
  });

  @override
  _ScreenUpdateNotesState createState() => _ScreenUpdateNotesState();
}

class _ScreenUpdateNotesState extends State<ScreenUpdateNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UpdatePersonForm(
          index: widget.index,
          person: widget.person,
        ),
      ),
    );
  }
}
