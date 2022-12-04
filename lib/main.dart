import 'package:chatai/views/home.dart';
import 'package:chatai/views/image.dart';
import 'package:chatai/views/text.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
      routes: {
        '/text': (context) => const TextView(),
        '/image': (context) => const ImageView(),
      },
    );
  }
}
