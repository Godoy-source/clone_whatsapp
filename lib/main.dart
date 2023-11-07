import 'package:clone_whatsapp/HomePage/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Clone2a3a',
      theme: ThemeData(
        primaryColor: Colors.white,
        shadowColor: const Color(0xff128c7e)
      ),
      home: HomePage(),
    );
  }
}
