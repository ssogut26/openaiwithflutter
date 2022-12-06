import 'package:chatai/views/chat.dart';
import 'package:chatai/views/emoji.dart';
import 'package:chatai/views/home.dart';
import 'package:chatai/views/image.dart';
import 'package:chatai/views/translate.dart';
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
        '/emoji': (context) => const MovieToEmojiView(),
        '/image': (context) => const ImageView(),
        '/chat': (context) => const ChatView(),
        '/translate': (context) => const TranslateView(),
      },
    );
  }
}
