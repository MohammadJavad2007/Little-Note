import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:little_note/Screen/ScreenNotes.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:little_note/lang/Translations.dart';
import 'package:little_note/models/hash.dart';
import 'package:little_note/models/person.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shamsi_date/shamsi_date.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'models/Install.dart';
import 'models/lang.dart';

// ignore: non_constant_identifier_names
Color color_dark = const Color.fromARGB(255, 74, 100, 247);
// ignore: non_constant_identifier_names
Color color_dark_AppBer = const Color(0xFF3D3D3D);

int colorTheme = 0xFF283CA9;
// int colorTheme = 0xFF718355;
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
  // Initialize hiv
  await Hive.initFlutter();
  // Registering the adapter
  Hive.registerAdapter(PersonAdapter());
  Hive.registerAdapter(InstallAdapter());
  Hive.registerAdapter(HashAdapter());
  Hive.registerAdapter(LangAdapter());
  // Opening the box]

  await Hive.openBox('NoteBox');
  await Hive.openBox('Install');
  await Hive.openBox('Hash');
  await Hive.openBox('Lang');
  Hive.box('Lang').add(Lang(lang: "", country: ""));

  runApp(const Notes());
}

// ignore: must_be_immutable
class Notes extends StatefulWidget {
  const Notes({super.key});
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  // dark mode
  // ignore: non_constant_identifier_names
  Darkmode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('repeat') == false) {
      Notes.themeNotifier.value = ThemeMode.dark;
      if (Platform.isAndroid) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor: color_dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            // systemNavigationBarDividerColor: null
          ),
        );
      }
      // print('dark');
    } else {
      Notes.themeNotifier.value = ThemeMode.light;
      // print(getitem);
      if (Platform.isAndroid) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor: color,
            systemNavigationBarIconBrightness: Brightness.light,
            // systemNavigationBarDividerColor: null
          ),
        );
      }
    }
  }

  final visit = "https://fireflutter.ir/API/visit/visit-post.php";
  // ignore: non_constant_identifier_names
  Visit() async {
    Hive.box('Hash').add(Hash(hash: "0fc302b63c7fa1d0bd1f343002c5eff9"));
    try {
      String hashcode = await Hive.box('Hash').getAt(0).hash;
      // ignore: unused_local_variable
      final response = await http.post(
        Uri.parse(visit),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{'visit': hashcode},
        ),
      );
    // ignore: empty_catches
    } on TimeoutException {
    // ignore: empty_catches
    } on SocketException {
    // ignore: empty_catches
    } on Error {}
  }

  final install = "https://fireflutter.ir/API/install/install-post.php";
  // ignore: non_constant_identifier_names
  Installer() async {
    if (Hive.box('Install').length == 0) {
      Hive.box('Install').add(Install(install: false));
    }
    if (Hive.box('Install').getAt(0).install == false) {
      try {
        String hashcode = await Hive.box('Hash').getAt(0).hash;
        // ignore: unused_local_variable
        final response = await http.post(
          Uri.parse(install),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, dynamic>{'install': hashcode},
          ),
        );
      // ignore: empty_catches
      } on TimeoutException {
      // ignore: empty_catches
      } on SocketException {
      // ignore: empty_catches
      } on Error {}
    }
    Hive.box('Install').putAt(0, Install(install: true));
  }

  Jalali j = Jalali(int.parse('1397'), 5, 6, 12, 56, 34, 585);
  @override
  void dispose() {
    // Closes all Hive boxes
    Hive.close();
    super.dispose();
  }

  @override
  void initState() {
    Darkmode();
    // ignore: unused_local_variable
    Visit();
    Installer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: Notes.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          translations: Languages(),
          locale: Hive.box('Lang').getAt(0).lang == ''
              ? Get.deviceLocale
              : Locale(Hive.box('Lang').getAt(0).lang,
                  Hive.box('Lang').getAt(0).country),
          fallbackLocale: const Locale('en', 'US'),
          // supportedLocales: [Locale('fa', 'IR'), Locale('en', 'US')],
          title: 'Notes',
          theme: ThemeData(
            primarySwatch: themeColor,
            bottomAppBarTheme: BottomAppBarTheme(color: themeColor),
            scaffoldBackgroundColor: const Color.fromARGB(255, 236, 236, 236),
          ),
          darkTheme: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(primary: color_dark),
            appBarTheme: AppBarTheme(backgroundColor: color_dark_AppBer),
            bottomAppBarTheme: BottomAppBarTheme(color: color_dark),
            floatingActionButtonTheme:
                FloatingActionButtonThemeData(backgroundColor: color_dark),
          ),
          themeMode: currentMode,
          home: ScreenNotes(),
        );
      },
    );
  }
}
