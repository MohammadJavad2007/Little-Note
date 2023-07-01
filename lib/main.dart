import 'package:flutter/material.dart';
import 'package:notes/Screen/ScreenNotes.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/models/person.dart';

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
      ValueNotifier(ThemeMode.light);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {



  // ignore: non_constant_identifier_names
  Color ColorTheme2() {
    return Color(0xFF6800DF);
  }

  MaterialColor themeColor = const MaterialColor(
    0xFF6800DF,
    <int, Color>{
      50: Color(0xFF6800DF),
      100: Color(0xFF6800DF),
      200: Color(0xFF6800DF),
      300: Color(0xFF6800DF),
      400: Color(0xFF6800DF),
      500: Color(0xFF6800DF),
      600: Color(0xFF6800DF),
      700: Color(0xFF6800DF),
      800: Color(0xFF6800DF),
      900: Color(0xFF6800DF),
    },
  );

  @override
  void dispose() {
    // Closes all Hive boxes
    Hive.close();
    super.dispose();
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
              appBarTheme: AppBarTheme(backgroundColor: Colors.grey[800]),
              floatingActionButtonTheme:
                  FloatingActionButtonThemeData(backgroundColor: themeColor)),
          themeMode: currentMode,
          home: ScreenNotes(),
        );
      },
    );
  }
}
