import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Clone2',
      theme: ThemeData(
        primaryColor: const Color(0xff128c7e),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xff075e54),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('WhatsApp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implementar ação de pesquisa
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Implementar ação de mais opções
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Conteúdo da Página Inicial'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implementar ação do botão de chat
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}
