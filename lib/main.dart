import 'package:flutter/material.dart';
import 'package:notes/Screen/ScreenNotes.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/models/person.dart';
import 'package:shared_preferences/shared_preferences.dart';



int colorTheme = 0xFF263799;
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
  // Opening the box]

  await Hive.openBox('NoteBox');

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
    super.initState();
  }

  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: Notes.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return GetMaterialApp(
          title: 'Notes',
          theme: ThemeData(
            primarySwatch: themeColor,
          ),
          darkTheme: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(primary: themeColor),
              appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(255, 58, 58, 58)),
              floatingActionButtonTheme:
                  FloatingActionButtonThemeData(backgroundColor: themeColor)),
          themeMode: currentMode,
          home: ScreenNotes(),
        );
      },
    );
  }
}
