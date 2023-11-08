import 'package:clone_whatsapp/HomePage/AppBar/appbar.dart';
import 'package:clone_whatsapp/HomePage/CardChat/cardChat.dart';
import 'package:clone_whatsapp/HomePage/Footer/footer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String?>> dataList = [
    {
      'nameOfPerson': 'Amigo 1',
      'lastMessage': 'Oi, como você está?',
      'urlImage': 'https://placekitten.com/100/100?image=1',
    },
    {
      'nameOfPerson': 'Amigo 2',
      'lastMessage': 'Vamos sair hoje à noite?',
      'urlImage': 'https://placekitten.com/100/100?image=2',
    },
    {
      'nameOfPerson': 'Amigo 3',
      'lastMessage': 'Estou enviando os documentos agora.',
      'urlImage': 'https://placekitten.com/100/100?image=3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: const MyAppBar(),
            backgroundColor: Theme.of(context).primaryColor,
            body: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return CardChat(
                      nameOfPerson: dataList[index]['nameOfPerson']!,
                      urlImage: dataList[index]['urlImage']!,
                      lastMessage: dataList[index]['lastMessage']!
                  );
                }),
            // floatingActionButton: FloatingActionButton(
            //   backgroundColor: const Color(0xff075e54),
            //   onPressed: () {
            //     // Implementar ação do botão de chat
            //   },
            //   child: const Icon(Icons.message),
            // ),
            // bottomNavigationBar: Footer()
        ),
      ),
    );
  }
}



class DetalhesChatScreen extends StatelessWidget {
  final String nameOfPerson;
  final String lastMessage;
  final String urlImage;

  const DetalhesChatScreen({
    Key? key,
    required this.nameOfPerson,
    required this.lastMessage,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameOfPerson),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundImage: NetworkImage(urlImage)),
            SizedBox(height: 16.0),
            Text("Last Message: $lastMessage"),
          ],
        ),
      ),
    );
  }
}



// Teste
// MaterialApp(
// home: DefaultTabController(
// length: 3,
// child: Scaffold(
// appBar: const MyAppBar(),
// backgroundColor: Theme.of(context).primaryColor,
// body: TabBarView(children: [
// ListView.builder(
// itemCount: dataList.length,
// itemBuilder: (context, index) {
// return CardChat(
// nameOfPerson: dataList[index]['nameOfPerson']!,
// urlImage: dataList[index]['urlImage']!,
// lastMessage: dataList[index]['lastMessage']!
// );
// }),
// Container(
// child: Text("Pagina 02"),
// ),
// Container(
// child: Text("Pagina 03"),
// )
// ]),
// floatingActionButton: FloatingActionButton(
// backgroundColor: const Color(0xff075e54),
// onPressed: () {
// // Implementar ação do botão de chat
// },
// child: const Icon(Icons.message),
// ),
// bottomNavigationBar: Footer()
// ),
// ),
// );
