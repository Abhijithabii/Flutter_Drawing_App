import 'package:drawing_app/features/draw/presentation/drawscreen.dart';
import 'package:drawing_app/features/home/presentation/homescreen.dart';
import 'package:drawing_app/features/splash/presentation/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paint Your Dreams',
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue[300]),
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Splashscreen(),
        '/home': (context) => const Homescreen(),
        '/draw': (context) => const Drawscreen(),
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
