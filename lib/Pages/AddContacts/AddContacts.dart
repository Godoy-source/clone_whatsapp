import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:clone_whatsapp/Pages/HomePage/Home.dart';
import 'package:clone_whatsapp/model/Contact.dart';
import 'package:uuid/uuid.dart';

class AddContacts extends StatefulWidget {
  final String emailUsuarioLogado;

  AddContacts({required this.emailUsuarioLogado});

  @override
  _AddContactsState createState() =>
      _AddContactsState(emailUsuarioLogado: emailUsuarioLogado);
}

class _AddContactsState extends State<AddContacts> {
  final String emailUsuarioLogado;
  String _mensagemErro = "";
  Color primaryColor = const Color(0xff128c7e);
  TextEditingController _controllerEmail = TextEditingController();

  _AddContactsState({required this.emailUsuarioLogado});

  void adicionarContato() async {
    String inputEmail = _controllerEmail.text;

    if (inputEmail.isNotEmpty) {
      try {
        Contact contato = await _buscarContato(inputEmail, emailUsuarioLogado);
        await FirebaseFirestore.instance.collection('contactsV2').add({
          'nameOfPerson': contato.nameOfContact,
          'emailContact': contato.emailContact,
          'urlImage': contato.urlImageContact,
          'keyRelationId': contato.keyRelationId,
          'contactOwner': emailUsuarioLogado
        });

        await FirebaseFirestore.instance
            .collection('notificacaoNovoContato')
            .add({
          'acionarEmail': contato.emailContact,
        });

        _controllerEmail.clear();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        setState(() {
          _mensagemErro =
              _mensagemErro.isEmpty ? 'Obs algo deu errado!' : _mensagemErro;
        });
      }
    } else {
      setState(() {
        _mensagemErro = 'Preencha todos os campos antes de salvar o contato.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Contato"),
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(width: 0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Icon(Icons.add_reaction,
                  size: constraints.maxWidth * 0.5, color: Colors.black);
            }),
            Text(
              "Adicionando Contato:",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 17,
                fontStyle: FontStyle.normal,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: TextField(
                controller: _controllerEmail,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  hintText: "Email do Contato",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  icon: Icon(Icons.alternate_email),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Center(
                child: Text(
                  _mensagemErro,
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                onPrimary: Colors.white,
                textStyle: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                adicionarContato();
              },
              child: Text("Salvar Contato"),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, String?>?> _findKeyRelacaoContato(
      String emailParaAdicionar, String emailUsuarioLogado) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('contactsV2')
        .where('contactOwner', isEqualTo: emailParaAdicionar)
        .where('emailContact', isEqualTo: emailUsuarioLogado)
        .get();

    List<Map<String, String?>> dataList = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return {'keyRelationId': data['keyRelationId'] as String?};
    }).toList();
    if (dataList.isEmpty) {
      return null;
    }
    return dataList[0];
  }

  Future<Contact> _buscarContato(
      String inputEmailUsuario, String emailUsuarioLogado) async {
    List<Map<Object, String?>> dadosUsuario =
        await _findUserByEmail(inputEmailUsuario);
    Map<String, String?>? keyRelationId =
        await _findKeyRelacaoContato(inputEmailUsuario, emailUsuarioLogado);
    String key = keyRelationId != null
        ? keyRelationId['keyRelationId']!
        : const Uuid().v4().toString();
    for (var dados in dadosUsuario) {
      return Contact(
          dados['nome']!, dados['fotoPerfil']!, key, "", dados['email']!);
    }
    throw Exception("Não foi possivel montar contato");
  }

  Future<List<Map<String, String?>>> _findUserByEmail(
      String emailUsuario) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('usuariosV2')
        .where('email', isEqualTo: emailUsuario)
        .get();

    List<Map<String, String?>> dataList = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return {
        'email': data['email'] as String?,
        'nome': data['nome'] as String?,
        'fotoPerfil': data['fotoPerfil'] as String?
      };
    }).toList();
    if (dataList.isEmpty) {
      setState(() {
        _mensagemErro = "Não foi possivel encontrar o usuário";
      });
    }
    return dataList;
  }
}
