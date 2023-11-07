import 'package:clone_whatsapp/HomePage/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardChat extends StatefulWidget implements PreferredSizeWidget {
  final String nameOfPerson;
  final String lastMessage;
  final String urlImage;

  const CardChat(
      {required this.nameOfPerson,
      required this.lastMessage,
      required this.urlImage});

  @override
  _CardChatWidget createState() => _CardChatWidget(
        nameOfPerson: nameOfPerson,
        lastMessage: lastMessage,
        urlImage: urlImage,
      );

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _CardChatWidget extends State<CardChat> {
  final String nameOfPerson;
  final String lastMessage;
  final String urlImage;

  _CardChatWidget({
    required this.nameOfPerson,
    required this.lastMessage,
    required this.urlImage,
  });

  @override
  Widget build(BuildContext context) {
    Color detalhesCores = Color(0xffe0e0e0);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesChatScreen(
              nameOfPerson: nameOfPerson,
              lastMessage: lastMessage,
              urlImage: urlImage,
            ),
          ),
        );
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: detalhesCores, width: 1.0)),
          ),
          child: Row(children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: detalhesCores, width: 1.0),
              ),
              child: CircleAvatar(backgroundImage: NetworkImage(urlImage)),
            ),
            SizedBox(width: 8.0),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                child: Text(
                  nameOfPerson,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                child: Text(lastMessage),
              ),
            ])
          ])),
    );
  }
}
