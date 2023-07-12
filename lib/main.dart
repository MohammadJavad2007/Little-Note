import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/Screen/ScreenNotes.dart';

// import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/lang/Translations.dart';
import 'package:notes/models/hash.dart';
import 'package:notes/models/person.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'models/Install.dart';

Color color_dark = Color.fromARGB(255, 172, 142, 255);
Color color_dark_AppBer = Color.fromARGB(255, 61, 61, 61);

int colorTheme = 0xFF4A148C;
Color color = Color(colorTheme);
MaterialColor themeColor = MaterialColor(
  colorTheme,
  <int, Color>{
    50: color,
    100: color,
    200: color,
    300: color,
    400: color,
    500: color,
    600: color,
    700: color,
    800: color,
    900: color,
  },
);

void main() async {
  // Initialize hive
  await Hive.initFlutter();
  // Registering the adapter
  Hive.registerAdapter(PersonAdapter());
  Hive.registerAdapter(InstallAdapter());
  Hive.registerAdapter(HashAdapter());
  // Opening the box]

  await Hive.openBox('NoteBox');
  await Hive.openBox('Install');
  await Hive.openBox('Hash');

  runApp(Notes());
}

// ignore: must_be_immutable
class Notes extends StatefulWidget {
  Notes({super.key});
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  // dark mode
  Darkmode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('repeat') == false) {
      Notes.themeNotifier.value = ThemeMode.dark;
      // print('dark');
    } else {
      Notes.themeNotifier.value = ThemeMode.light;
      // print(getitem);
    }

    // ignore: unused_local_variable
  }

  // internet() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       print('connected');
  //     }
  //   } on SocketException catch (_) {
  //     print('not connected');
  //   }
  // }

  final visit = "http://localhost/visit/visit-post.php";
  Visit() async {
    Hive.box('Hash').add(Hash(hash: "0fc302b63c7fa1d0bd1f343002c5eff9"));
    try {
      String hashcode = await Hive.box('Hash').getAt(0).hash;
      final response = await http.post(
        Uri.parse(visit),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{'visit': hashcode},
        ),
      );
      // final jsonData = response.body;
      print('visit = ${response.body}');
    } on TimeoutException {
    } on SocketException {
    } on Error {}
  }

  final install = "http://localhost/install/install-post.php";
  Installer() async {
    if (Hive.box('Install').length == 0) {
      Hive.box('Install').add(Install(install: false));
    }
    if (Hive.box('Install').getAt(0).install == false) {
      try {
        String hashcode = await Hive.box('Hash').getAt(0).hash;
        final response = await http.post(
          Uri.parse(install),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, dynamic>{'install': hashcode},
          ),
        );
        // final jsonData = response.body;
        print('install = ${response.body}');
      } on TimeoutException {
      } on SocketException {
      } on Error {}
    }
    Hive.box('Install').putAt(0, Install(install: true));
  }

  @override
  void dispose() {
    // Closes all Hive boxes
    Hive.close();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    Darkmode();
    // internet();
    // ignore: unused_local_variable
    Visit();
    Installer();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var a = Translations.of(context)?.text('title');
    // print(a);
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: Notes.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return GetMaterialApp(
          // localizationsDelegates: [
          //   // AppLocalizationsDelegate(),
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          // supportedLocales: [
          //   Locale('fa',''),
          //   Locale('en',''),
          // ],
          // localizationsDelegates: [
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          // // translations: Translation(),
          // locale: Locale('fa', 'IR'),
          // fallbackLocale: Locale('en', 'US'),
          // supportedLocales: [Locale('fa', 'IR'), Locale('en', 'US')],
          title: 'Notes',
          theme: ThemeData(
            primarySwatch: themeColor,
          ),
          darkTheme: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(primary: color_dark),
              appBarTheme: AppBarTheme(backgroundColor: color_dark_AppBer),
              floatingActionButtonTheme:
                  FloatingActionButtonThemeData(backgroundColor: color_dark)),
          themeMode: currentMode,
          home: ScreenNotes(),
        );
      },
    );
  }
}

