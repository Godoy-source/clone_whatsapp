import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  @override
  _MyFooterBar createState() => _MyFooterBar();
}

class _MyFooterBar extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 50,
      child: Container(
        child: Center(
          child: Text(
              "Suas mensagens pessoais são protegidas com a criptografia de ponta"),
        ),
      ),
    );
  }
}
