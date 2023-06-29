import 'package:flutter/material.dart';

import 'package:notes/models/person.dart';
import 'package:hive/hive.dart';

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
  final _personFormKey = GlobalKey<FormState>();

  late final _nameController;
  late final _countryController;
  late final Box box;

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  // Update info of people box
  _updateInfo() {
    Person newPerson = Person(
      name: _nameController.text,
      country: _countryController.text,
    );

    box.putAt(widget.index, newPerson);
  }

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = Hive.box('NoteBox');
    _nameController = TextEditingController(text: widget.person.name);
    _countryController = TextEditingController(text: widget.person.country);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update a note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _personFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title'),
                TextFormField(
                  controller: _nameController,
                  validator: _fieldValidator,
                ),
                SizedBox(height: 24.0),
                Text('Description'),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _countryController,
                  validator: _fieldValidator,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
        child: Container(
          width: double.maxFinite,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (_personFormKey.currentState!.validate()) {
                _updateInfo();
                Navigator.of(context).pop();
              }
            },
            child: Text('Save'),
          ),
        ),
      ),
    );
  }
}
