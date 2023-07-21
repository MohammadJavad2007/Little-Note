// ignore_for_file: file_names

// import 'dart:math';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:localstorage/localstorage.dart';
import 'package:notes/Screen/ScreenAddNotes.dart';
import 'package:notes/Screen/ScreenUpdateNotes.dart';
import 'package:notes/main.dart';
import 'package:notes/models/lang.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:notes/models/person.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

// class MyHomePage extends GetView<MyDrawerController> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MyDrawerController>(
//       builder: (_) => ZoomDrawer(
//         controller: _.zoomDrawerController,
//         style: DrawerStyle.defaultStyle,
//         menuScreen: MenuScreen(),
//         mainScreen: ScreenNotes(),
//         borderRadius: 24.0,
//         showShadow: true,
//         angle: 0.0,
//         drawerShadowsBackgroundColor: Color.fromARGB(69, 158, 158, 158),
//         menuBackgroundColor: Theme.of(context).primaryColor,
//         slideWidth: MediaQuery.of(context).size.width * .50,
//         openCurve: Curves.linear,
//         closeCurve: Curves.ease,
//       ),
//     );
//   }
// }

// class MenuScreen extends GetView<MyDrawerController> {
//   const MenuScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Theme.of(context).primaryColor,
//     );
//   }
// }

// class MyDrawerController extends GetxController {
//   final zoomDrawerController = ZoomDrawerController();

//   void toggleDrawer() {
//     print("Toggle drawer");
//     zoomDrawerController.toggle?.call();
//     update();
//   }
// }

// ignore: must_be_immutable
class ScreenNotes extends StatefulWidget {
  ScreenNotes({super.key});
  // SharedPreferences prefs() async {
  //   return await SharedPreferences.getInstance();
  // }

  // bool? darkmode = LocalStorage('darkmode.json').getItem('themedata');
  final List<String> list = List.generate(10, (index) => "Note $index");
  @override
  State<ScreenNotes> createState() => _ScreenNotesState();
}

class _ScreenNotesState extends State<ScreenNotes> {
  toggle() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('repeat', true);
    // bool? toggleStorage = await widget.prefs.s('repeat', true);
    if (prefs.getBool('repeat') == false) {
      Notes.themeNotifier.value = ThemeMode.light;
      // print(toggleStorage);
      await prefs.setBool('repeat', true);
      // widget.darkmode = true;
    } else {
      Notes.themeNotifier.value = ThemeMode.dark;
      // widget.darkmode = false;
      await prefs.setBool('repeat', false);
      // print(toggleStorage);
    }
  }

  late final Box contactBox;

  // Darkmode() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // bool? getitem = widget.storage.getItem('themedata');
  //   WidgetsBinding.instance.addPostFrameCallback(
  //     (_) => setState(
  //       () {
  //         // await prefs.setBool('repeat', false);
  //         if (prefs.getBool('repeat') == false) {
  //           Notes.themeNotifier.value = ThemeMode.dark;
  //           // print('dark');
  //         } else {
  //           Notes.themeNotifier.value = ThemeMode.light;
  //           // print(getitem);
  //         }
  //       },
  //     ),
  //   );
  // }

  _deleteInfo(int index) {
    contactBox.deleteAt(index);
  }

  // bool _isGridMode = false;
  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    // Darkmode();
    contactBox = Hive.box('NoteBox');
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.deepOrange,
          systemNavigationBarIconBrightness: Brightness.light));
    }
    // print(storage.getItem('darkMode'));
  }

  double value = 0;
  int x = 0;

  // int sized = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(0, 0, 0, 0), // <-- SEE HERE
          ),
          title: Text('Notes'.tr),
          actions: [
            PopupMenuButton<int>(
              icon: Icon(Icons.translate),
              tooltip: '',
              itemBuilder: (context) => [
                // PopupMenuItem 1
                PopupMenuItem(
                  value: 1,
                  // row with 2 children
                  child: Row(
                    children: [Text("فارسی")],
                  ),
                ),
                // PopupMenuItem 2
                PopupMenuItem(
                  value: 2,
                  // row with two children
                  child: Row(
                    children: [Text("English")],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  // row with two children
                  child: Row(
                    children: [Text("한국인")],
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 1:
                    Get.updateLocale(const Locale('fa'));
                    Hive.box('Lang').putAt(0, Lang(lang: 'fa', country: 'IR'));
                    break;
                  case 2:
                    Get.updateLocale(const Locale('en'));
                    Hive.box('Lang').putAt(0, Lang(lang: 'en', country: 'US'));
                    break;
                  case 3:
                    Get.updateLocale(const Locale('ko'));
                    Hive.box('Lang').putAt(0, Lang(lang: 'ko', country: 'KR'));

                    break;
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Notes.themeNotifier.value == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                onPressed: toggle,
              ),
            ),
          ],
        ),
        // body
        body: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: ValueListenableBuilder(
            valueListenable: contactBox.listenable(),
            builder: (context, Box box, widget) {
              if (box.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                      child: Icon(
                        Icons.note_add,
                        size: 60,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Write Your First Note'.tr),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => ScreenAddNotes(),
                                duration: Duration(milliseconds: 250),
                                transition: Transition.rightToLeftWithFade);
                          },
                          child: Text(
                            'ADD NEW NOTE'.tr,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    var currentBox = box;
                    var personData = currentBox.getAt(index)!;
                    // ignore: unused_local_variable
                    int month = 1;
                    switch (personData.dateTime.toString().split(' ')[0]) {
                      case 'January':
                        month = 1;
                      // return 'January';
                      case 'February':
                        month = 2;
                      // return 'February';
                      case 'March':
                        month = 3;
                      // return 'March';
                      case 'April':
                        month = 4;
                      // return 'April';
                      case 'May':
                        month = 5;
                      // return 'May';
                      case 'June':
                        month = 6;
                      // return 'June';
                      case 'July':
                        month = 7;
                      // return 'July';
                      case 'August':
                        month = 8;
                      // return 'August';
                      case 'September':
                        month = 9;
                      // return 'September';
                      case 'October':
                        month = 10;
                      // return 'October';
                      case 'November':
                        month = 11;
                      // return 'November';
                      case 'December':
                        month = 12;
                      // return 'December';
                    }
                    final year = 'Notes'.tr == 'یادداشت ها'
                        ? DateTime(
                            int.parse(
                                personData.dateTime.toString().split(' ')[2]),
                            month,
                            int.parse(
                                personData.dateTime.toString().split(' ')[1]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[3]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[5]),
                          ).toJalali().year
                        : DateTime(
                            int.parse(
                                personData.dateTime.toString().split(' ')[2]),
                            month,
                            int.parse(
                                personData.dateTime.toString().split(' ')[1]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[3]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[5]),
                          ).year;
                    final day = 'Notes'.tr == 'یادداشت ها'
                        ? DateTime(
                            int.parse(
                                personData.dateTime.toString().split(' ')[2]),
                            month,
                            int.parse(
                                personData.dateTime.toString().split(' ')[1]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[3]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[5]),
                          ).toJalali().day
                        : DateTime(
                            int.parse(
                                personData.dateTime.toString().split(' ')[2]),
                            month,
                            int.parse(
                                personData.dateTime.toString().split(' ')[1]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[3]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[5]),
                          ).day;
                    final hour = 'Notes'.tr == 'یادداشت ها'
                        ? DateTime(
                            int.parse(
                                personData.dateTime.toString().split(' ')[2]),
                            month,
                            int.parse(
                                personData.dateTime.toString().split(' ')[1]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[3]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[5]),
                          ).toJalali().hour
                        : DateTime(
                            int.parse(
                                personData.dateTime.toString().split(' ')[2]),
                            month,
                            int.parse(
                                personData.dateTime.toString().split(' ')[1]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[3]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[5]),
                          ).hour;
                    final minute = 'Notes'.tr == 'یادداشت ها'
                        ? DateTime(
                            int.parse(
                                personData.dateTime.toString().split(' ')[2]),
                            month,
                            int.parse(
                                personData.dateTime.toString().split(' ')[1]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[3]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[5]),
                          ).toJalali().minute
                        : DateTime(
                            int.parse(
                                personData.dateTime.toString().split(' ')[2]),
                            month,
                            int.parse(
                                personData.dateTime.toString().split(' ')[1]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[3]),
                            int.parse(
                                personData.dateTime.toString().split(' ')[5]),
                          ).minute;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.bounceIn,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(57, 187, 187, 187),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              () => ScreenUpdateNotes(
                                index: index,
                                person: personData,
                              ),
                              duration: const Duration(milliseconds: 250),
                              transition: Transition.rightToLeftWithFade,
                            );
                          },
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  personData.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  personData.country,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            // ignore: unused_label
                                            title: Text(
                                              'Do you really want to delete the note?'
                                                  .tr,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            // content: Center(),
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
                                                  _deleteInfo(index);
                                                  Get.back();
                                                },
                                                child: Text('Delete'.tr),
                                              ),
                                            ]);
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Divider(),
                              Container(
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.only(bottom: 15),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    'Notes'.tr == 'یادداشت ها'
                                        ? '${hour > 9 ? hour : '0' + hour.toString()}:${minute > 9 ? minute : '0' + minute.toString()}  ,${year}  ,${day > 9 ? day : '0' + day.toString()}  ,${personData.dateTime.toString().split(' ')[0].tr}'
                                        : '${personData.dateTime.toString().split(' ')[0].tr},  ${day > 9 ? day : '0' + day.toString()},  ${year},  ${hour > 9 ? hour : '0' + hour.toString()}:${minute > 9 ? minute : '0' + minute.toString()}',
                                    key: UniqueKey(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        extendBodyBehindAppBar: false,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          // color: Theme.of(context).colorScheme.primary,
          child: Container(
            height: 60,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => ScreenAddNotes(),
                duration: Duration(milliseconds: 250),
                transition: Transition.rightToLeftWithFade);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        // Navigator.pop(context);
        Get.back();
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = ["Note 3", "Note 2"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
            // In the false case
            (element) => element.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? const Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
