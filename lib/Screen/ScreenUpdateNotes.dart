import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notes/models/person.dart';
import 'package:hive/hive.dart';

// import 'ScreenNotes.dart';

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

  late final _dateController;
  late final _nameController;
  late final _countryController;
  late final Box box;

// month data time
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

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty'.tr;
    }
    return null;
  }

  // Update info of people box
  _updateInfo() {
    setState(() {
      _dateController.text =
          '${month()}, ${time.day > 9 ? time.day : '0' + time.day.toString()}, ${time.year}   ${time.hour > 9 ? time.hour : '0' + time.hour.toString()}:${time.minute > 9 ? time.minute : '0' + time.minute.toString()}';
    });
    Person newPerson = Person(
      name: _nameController.text,
      country: _countryController.text,
      dateTime: _dateController.text,
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
    _dateController = TextEditingController(text: widget.person.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update a note'.tr),
        leading: IconButton(
          onPressed: () {
            if ((_countryController.text ==
                    Hive.box('NoteBox').getAt(widget.index).country) &
                (_nameController.text ==
                    Hive.box('NoteBox').getAt(widget.index).name)) {
              Get.back();
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    // ignore: unused_label
                    title: Text(
                      'Save your changes or discard them?'.tr,
                      style: TextStyle(fontSize: 15),
                    ),
                    // ignore: unused_label
                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 35,
                              child: TextButton(
                                child: Text("Cancle".tr),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 65,
                                  height: 35,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      Get.back();
                                      Get.back();
                                    },
                                    child: Text('Discard'.tr),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                SizedBox(
                                  width: 60,
                                  height: 35,
                                  child: TextButton(
                                    style: TextButton.styleFrom(),
                                    onPressed: () {
                                      if (_personFormKey.currentState!
                                          .validate()) {
                                        _updateInfo();
                                        Get.back();
                                        Get.back();
                                      }
                                      Get.back();
                                    },
                                    child: Text('Save'.tr),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _personFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title'.tr),
                TextFormField(
                  controller: _nameController,
                  validator: _fieldValidator,
                ),
                SizedBox(height: 24.0),
                Text('Description'.tr),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _countryController,
                  validator: _fieldValidator,
                ),
                SizedBox(height: 24.0),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${_dateController.text}",
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
        padding: const EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 20.0),
        child: Container(
          width: double.maxFinite,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (_personFormKey.currentState!.validate()) {
                _updateInfo();
                Get.back();
              }
            },
            child: Text(
              'Save'.tr,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
