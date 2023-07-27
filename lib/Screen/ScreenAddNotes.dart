// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:notes/main.dart';
import 'package:notes/models/person.dart';
import 'package:shamsi_date/shamsi_date.dart';

class ScreenAddNotes extends StatefulWidget {
  const ScreenAddNotes({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenAddNotesState createState() => _ScreenAddNotesState();
}

class _ScreenAddNotesState extends State<ScreenAddNotes> {
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _dateController = TextEditingController();
  final _personFormKey = GlobalKey<FormState>();

  late final Box box;

  var time = Jalali.now().toGregorian();
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

  // Add info to people box
  _addInfo() async {
    setState(() {
      _dateController.text =
          '${month()} ${time.day} ${time.year} ${time.hour} : ${time.minute}';
    });
    Person newPerson = Person(
        name: _nameController.text,
        country: _countryController.text,
        dateTime: _dateController.text);

    box.add(newPerson);
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box('NoteBox');
  }

  Icon copy = const Icon(Icons.copy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a note'.tr),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: IconButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(
                      text:
                          '${_nameController.text}\n${_countryController.text}'));
                  setState(() {
                    copy = const Icon(Icons.task);
                  });
                },
                icon: copy),
          )
        ],
        leading: IconButton(
          onPressed: () {
            if ((_countryController.text == '') &
                (_nameController.text == '')) {
              Get.back();
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    // ignore: unused_label
                    title: Text(
                      'Save your changes or discard them?'.tr,
                      style: const TextStyle(fontSize: 15),
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
                                const SizedBox(
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
                                        _addInfo();
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
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _personFormKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title'.tr),
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  validator: _fieldValidator,
                ),
                const SizedBox(height: 24.0),
                Text('Description'.tr),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: _countryController,
                  validator: _fieldValidator,
                  maxLines: null,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 20.0),
        child: SizedBox(
          width: double.maxFinite,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (_personFormKey.currentState!.validate()) {
                _addInfo();
                Get.back();
              }
            },
            child: Text(
              'Save'.tr,
              style: TextStyle(
                  color: Notes.themeNotifier.value == ThemeMode.light
                      ? Colors.white
                      : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
