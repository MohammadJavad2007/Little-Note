import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:notes/Screen/ScreenNotes.dart';
import 'package:notes/models/person.dart';

class ScreenAddNotes extends StatefulWidget {
  @override
  _ScreenAddNotesState createState() => _ScreenAddNotesState();
}

class _ScreenAddNotesState extends State<ScreenAddNotes> {
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _personFormKey = GlobalKey<FormState>();

  late final Box box;
  var time = DateTime.now();

  String month() {
    switch (time.month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
    }
    return '';
  }

  //  void dateTime() {
  // return date;
  // }

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  // Add info to people box
  _addInfo() async {
    setState(() {
      date =
          '${month()}, ${time.day > 9 ? time.day : '0' + time.day.toString()}, ${time.year}   ${time.hour > 9 ? time.hour : '0' + time.hour.toString()}:${time.minute > 9 ? time.minute : '0' + time.minute.toString()}';
    });
    Person newPerson = Person(
      name: _nameController.text,
      country: _countryController.text,
    );

    box.add(newPerson);
  }

  String date = '';

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = Hive.box('NoteBox');
    // date.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a note'),
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
                  controller: _countryController,
                  validator: _fieldValidator,
                  maxLines: null,
                ),
                SizedBox(height: 24.0),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${date}",
                    key: UniqueKey(),
                    style: TextStyle(fontSize: 15),
                  ),
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
                _addInfo();
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
