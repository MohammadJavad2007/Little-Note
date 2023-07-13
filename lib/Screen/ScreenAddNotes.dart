import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
// import 'package:notes/Screen/ScreenNotes.dart';
import 'package:notes/models/person.dart';
import 'package:shamsi_date/shamsi_date.dart';

class ScreenAddNotes extends StatefulWidget {
  @override
  _ScreenAddNotesState createState() => _ScreenAddNotesState();
}

class _ScreenAddNotesState extends State<ScreenAddNotes> {
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _dateController = TextEditingController();
  final _personFormKey = GlobalKey<FormState>();

  late final Box box;

  // data time
  var time = 'Notes'.tr == 'یادداشت ها' ? Jalali.now() : Jalali.now().toGregorian();
  String month() {
    switch (time.month) {
      case 1:
        return 'Notes'.tr == 'یادداشت ها' ? ' فروردین' : 'January';
        // return 'January';
      case 2:
        return 'Notes'.tr == 'یادداشت ها' ? ' اردیبهشت' : 'February';
        // return 'February';
      case 3:
        return 'Notes'.tr == 'یادداشت ها' ? ' خرداد' : 'March';
        // return 'March';
      case 4:
        return 'Notes'.tr == 'یادداشت ها' ? ' تیر ' : 'April';
        // return 'April';
      case 5:
        return 'Notes'.tr == 'یادداشت ها' ? ' مرداد' : 'May';
        // return 'May';
      case 6:
        return 'Notes'.tr == 'یادداشت ها' ? ' شهریور' : 'June';
        // return 'June';
      case 7:
        return 'Notes'.tr == 'یادداشت ها' ? ' مهر' : 'July';
        // return 'July';
      case 8:
        return 'Notes'.tr == 'یادداشت ها' ? ' آبان' : 'August';
        // return 'August';
      case 9:
        return 'Notes'.tr == 'یادداشت ها' ? ' آذر' : 'September';
        // return 'September';
      case 10:
        return 'Notes'.tr == 'یادداشت ها' ? ' دی' : 'October';
        // return 'October';
      case 11:
        return 'Notes'.tr == 'یادداشت ها' ? ' بهمن' : 'November';
        // return 'November';
      case 12:
        return 'Notes'.tr == 'یادداشت ها' ? ' اسفند' : 'December';
        // return 'December';
    }
    return '';
  }

  //  void dateTime() {
  // return date;
  // }

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
          '${month()} ${time.day > 9 ? time.day : '0' + time.day.toString()} ${time.year} ${time.hour > 9 ? time.hour : '0' + time.hour.toString()} : ${time.minute > 9 ? time.minute : '0' + time.minute.toString()}';
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
    // Get reference to an already opened box
    box = Hive.box('NoteBox');
    // date.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a note'.tr),
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
                  controller: _countryController,
                  validator: _fieldValidator,
                  maxLines: null,
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
                _addInfo();
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
