import 'package:firebase_core/firebase_core.dart';
import 'package:clone_whatsapp/Pages/Auth/Login.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projeto_whats',
      theme: ThemeData(
          primaryColor: Colors.white,
          shadowColor: const Color(0xff128c7e)
      ),
      home: Login(),
    );
  }
}
