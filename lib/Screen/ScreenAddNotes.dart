import 'package:flutter/material.dart';
import 'package:notes/utils/add_person_form.dart';

class ScreenAddNotes extends StatefulWidget {
  @override
  _ScreenAddNotesState createState() => _ScreenAddNotesState();
}

class _ScreenAddNotesState extends State<ScreenAddNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Info'),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AddPersonForm(),
      ),
    );
  }
}
