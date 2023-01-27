import 'package:flutter/material.dart';

import 'app/di/di.dart';
import 'app/view/notelist.dart';

void main() {
  DI().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const NoteScreen(), //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
