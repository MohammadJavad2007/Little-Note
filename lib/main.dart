import 'package:flutter/material.dart';
import 'package:notes/Screen/ScreenNotes.dart';
import 'package:get/get.dart';

void main() {
  runApp(Notes());
}

// ignore: must_be_immutable
class Notes extends StatelessWidget {
  Notes({super.key});
  MaterialColor themeColor = Colors.blue;
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

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
