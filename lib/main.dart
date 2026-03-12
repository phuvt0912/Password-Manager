import 'package:flutter/material.dart';
import 'UI/home_screen.dart';
import 'database/db_helper.dart';
import '../database/sharepref_helper.dart';
void main() {
  DatabaseHelper.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  Future<void> loadThemeState() async {
    bool themeState = await Shareprefshelper.getThemeState();

    setState(() {
      isDarkMode = themeState;
    });
  }

  Future<void> changeTheme(bool value) async {

    await Shareprefshelper.changeThemeState();

    setState(() {
      isDarkMode = value;
    });

  }

  @override
  void initState() {
    super.initState();
    loadThemeState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: changeTheme,
      ),
    );
  }
}
