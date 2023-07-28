// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes/main.dart';

import 'package:notes/models/person.dart';
import 'package:hive/hive.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ScreenUpdateNotes extends StatefulWidget {
  final int index;
  final Person person;

  const ScreenUpdateNotes({
    super.key,
    required this.index,
    required this.person,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ScreenUpdateNotesState createState() => _ScreenUpdateNotesState();
}

class _ScreenUpdateNotesState extends State<ScreenUpdateNotes> {
  final _personFormKey = GlobalKey<FormState>();

  // ignore: prefer_typing_uninitialized_variables
  late final _dateController;
  // ignore: prefer_typing_uninitialized_variables
  late final _nameController;
  // ignore: prefer_typing_uninitialized_variables
  late final _countryController;
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

  // Update info of people box
  _updateInfo() {
    setState(() {
      _dateController.text =
          '${month()} ${time.day} ${time.year} ${time.hour} : ${time.minute}';
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

  Icon copy = const Icon(Icons.copy);
  @override
  Widget build(BuildContext context) {
    int month = 1;
    switch (_dateController.text.toString().split(' ')[0]) {
      case 'January':
        month = 1;
      case 'February':
        month = 2;
      case 'March':
        month = 3;
      case 'April':
        month = 4;
      case 'May':
        month = 5;
      case 'June':
        month = 6;
      case 'July':
        month = 7;
      case 'August':
        month = 8;
      case 'September':
        month = 9;
      case 'October':
        month = 10;
      case 'November':
        month = 11;
      case 'December':
        month = 12;
    }
    final year = 'Notes'.tr == 'یادداشت ها'
        ? DateTime(
            int.parse(_dateController.text.toString().split(' ')[2]),
            month,
            int.parse(_dateController.text.toString().split(' ')[1]),
            int.parse(_dateController.text.toString().split(' ')[3]),
            int.parse(_dateController.text.toString().split(' ')[5]),
          ).toJalali().year
        : DateTime(
            int.parse(_dateController.text.toString().split(' ')[2]),
            month,
            int.parse(_dateController.text.toString().split(' ')[1]),
            int.parse(_dateController.text.toString().split(' ')[3]),
            int.parse(_dateController.text.toString().split(' ')[5]),
          ).year;
    // ignore: no_leading_underscores_for_local_identifiers
    final _month = 'Notes'.tr == 'یادداشت ها'
        ? DateTime(
            int.parse(_dateController.text.toString().split(' ')[2]),
            month,
            int.parse(_dateController.text.toString().split(' ')[1]),
            int.parse(_dateController.text.toString().split(' ')[3]),
            int.parse(_dateController.text.toString().split(' ')[5]),
          ).toJalali().month
        : DateTime(
            int.parse(_dateController.text.toString().split(' ')[2]),
            month,
            int.parse(_dateController.text.toString().split(' ')[1]),
            int.parse(_dateController.text.toString().split(' ')[3]),
            int.parse(_dateController.text.toString().split(' ')[5]),
          ).month;
    final day = 'Notes'.tr == 'یادداشت ها'
        ? DateTime(
            int.parse(_dateController.text.toString().split(' ')[2]),
            month,
            int.parse(_dateController.text.toString().split(' ')[1]),
            int.parse(_dateController.text.toString().split(' ')[3]),
            int.parse(_dateController.text.toString().split(' ')[5]),
          ).toJalali().day
        : DateTime(
            int.parse(_dateController.text.toString().split(' ')[2]),
            month,
            int.parse(_dateController.text.toString().split(' ')[1]),
            int.parse(_dateController.text.toString().split(' ')[3]),
            int.parse(_dateController.text.toString().split(' ')[5]),
          ).day;
    final hour = 'Notes'.tr == 'یادداشت ها'
        ? DateTime(
            int.parse(_dateController.text.toString().split(' ')[2]),
            month,
            int.parse(_dateController.text.toString().split(' ')[1]),
            int.parse(_dateController.text.toString().split(' ')[3]),
            int.parse(_dateController.text.toString().split(' ')[5]),
          ).toJalali().hour
        : DateTime(
            int.parse(_dateController.text.toString().split(' ')[2]),
            month,
            int.parse(_dateController.text.toString().split(' ')[1]),
            int.parse(_dateController.text.toString().split(' ')[3]),
            int.parse(_dateController.text.toString().split(' ')[5]),
          ).hour;
    final minute = 'Notes'.tr == 'یادداشت ها'
        ? DateTime(
            int.parse(_dateController.text.toString().split(' ')[2]),
            month,
            int.parse(_dateController.text.toString().split(' ')[1]),
            int.parse(_dateController.text.toString().split(' ')[3]),
            int.parse(_dateController.text.toString().split(' ')[5]),
          ).toJalali().minute
        : DateTime(
            int.parse(_dateController.text.toString().split(' ')[2]),
            month,
            int.parse(_dateController.text.toString().split(' ')[1]),
            int.parse(_dateController.text.toString().split(' ')[3]),
            int.parse(_dateController.text.toString().split(' ')[5]),
          ).minute;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update a note'.tr),
        actions: [
          IconButton(
            iconSize: 29,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    // ignore: unused_label
                    title: Text(
                      'Are you sure you want to delete your text?'.tr,
                      style: const TextStyle(fontSize: 15),
                    ),
                    // ignore: unused_label
                    actions: <Widget>[
                      TextButton(
                        child: Text("Cancle".tr),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        onPressed: () {
                          _countryController.text = '';
                          _nameController.text = '';
                          Get.back();
                        },
                        child: Text('Delete'.tr),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete_sweep),
          ),
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
              icon: copy,
            ),
          ),
        ],
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
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 13, right: 13, bottom: 13),
        child: Form(
          key: _personFormKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 13,
                ),
                Text('Title'.tr),
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  validator: _fieldValidator,
                ),
                const SizedBox(height: 24.0),
                Text('Description'.tr),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _countryController,
                  validator: _fieldValidator,
                ),
                const SizedBox(height: 14.0),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Notes'.tr == 'یادداشت ها'
                        // ignore: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings
                        ? '${hour > 9 ? hour : '0' + hour.toString()}:${minute > 9 ? minute : '0' + minute.toString()}  ,${year}  ,${day > 9 ? day : '0' + day.toString()}  ,${_month.toString().tr}'
                            .toPersianDigit()
                        // ignore: prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps
                        : '${_month.toString().tr},  ${day > 9 ? day : '0' + day.toString()},  ${year},  ${hour > 9 ? hour : '0' + hour.toString()}:${minute > 9 ? minute : '0' + minute.toString()}',
                    key: UniqueKey(),
                    style: const TextStyle(fontSize: 15),
                  ),
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
              if ((_countryController.text ==
                      Hive.box('NoteBox').getAt(widget.index).country) &
                  (_nameController.text ==
                      Hive.box('NoteBox').getAt(widget.index).name)) {
                Get.back();
              } else {
                if (_personFormKey.currentState!.validate()) {
                  _updateInfo();
                  Get.back();
                }
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
