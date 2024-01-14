import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clone_whatsapp/Pages/AddContacts/addContacts.dart';
import 'package:clone_whatsapp/Pages/HomePage/AppBar/appbar.dart';
import 'package:clone_whatsapp/Pages/HomePage/ContactCard/ContactCard.dart';
import 'package:clone_whatsapp/model/Contact.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _emailUsuario = "";
  String _nomeUsuarioLogado = "";
  String _fotoUsuarioLogado = "";
  List<Contact> _contactList = [];

  Future _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = auth.currentUser;
    if (usuarioLogado != null) {
      setState(() {
        _emailUsuario = usuarioLogado?.email ?? "UNDEFINED";
        _nomeUsuarioLogado = usuarioLogado?.displayName ?? "UNDEFINED";
        _fotoUsuarioLogado = usuarioLogado?.photoURL ??
            "https://cdn.pixabay.com/photo/2020/01/14/09/20/anonym-4764566_1280.jpg";
      });
    }
  }

  @override
  void initState() {
    _recuperarDadosUsuario()
        .then((value) => {_montarListaContatos(_emailUsuario)});
    super.initState();
  }

  Color primaryColor = const Color(0xff128c7e);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: MyAppBar(fotoUsuarioLogado: _fotoUsuarioLogado),
          backgroundColor: Colors.white,
          body: TabBarView(
            children: [
              Stack(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('notificacaoNovoContato')
                        .where('acionarEmail', isEqualTo: _emailUsuario)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        DocumentSnapshot doc = snapshot.data!.docs[0];
                        _excluirDocumento(doc.id);
                        _montarListaContatos(_emailUsuario);
                      }
                      return ListView.builder(
                          itemCount: _contactList.length,
                          itemBuilder: (context, index) {
                            return ContactCard(
                                nameOfPerson: _contactList[index].nameOfContact,
                                urlImage: _contactList[index].urlImageContact,
                                emailUsuario: _emailUsuario,
                                keyRelationId:
                                    _contactList[index].keyRelationId,
                                meuContato:
                                    _contactList[index].meuContato == "true"
                                // lastMessage: dataList[index]['lastMessage']!
                                );
                          });
                    },
                  ),
                ],
              ),
              Container(
                child: Text("Pagina 02"),
              ),
              Container(
                child: Text("Pagina 03"),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xff075e54),
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddContacts(emailUsuarioLogado: _emailUsuario)));
            },
            child: const Icon(Icons.person_add_alt_1),
          ),
        ),
      ),
    );
  }

  _montarListaContatos(String emailUsuarioLogado) async {
    List<Map<Object, String?>> listaMyContacts =
        await getListContacts(emailUsuarioLogado, 'contactOwner');
    listaMyContacts
        .addAll(await getListContacts(emailUsuarioLogado, 'emailContact'));

    Set<String?> uniqueKeys = Set<String?>();
    List<Contact> contact = [];

    for (var element in listaMyContacts) {
      String? keyRelationId = element['keyRelationId'];
      if (!uniqueKeys.contains(keyRelationId)) {
        uniqueKeys.add(keyRelationId);
        if (element['contactOwner']! == emailUsuarioLogado) {
          contact.add(Contact(
              element['nameOfPerson']!,
              element['urlImage']!,
              element['keyRelationId']!,
              (element['contactOwner']! == emailUsuarioLogado).toString(),
              ""));
        } else {
          Map<String, String?>? dadosContraparte =
              await _findUserByEmail(element['contactOwner']!);
          if (dadosContraparte != null) {
            contact.add(Contact(
                dadosContraparte['email']!,
                dadosContraparte['fotoPerfil']!,
                element['keyRelationId']!,
                (element['contactOwner']! == emailUsuarioLogado).toString(),
                ""));
          }
        }
      }
    }

    setState(() {
      _contactList.clear();
      _contactList.addAll(contact);
    });
  }

  Future<Map<String, String?>?> _findUserByEmail(String emailUsuario) async {
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
      print("Usuario não encontrado! $emailUsuario");
      return null;
    }
    return dataList[0];
  }

  Future<List<Map<String, String?>>> getListContacts(
      String emailUsuarioLogado, String chaveBusca) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('contactsV2')
        .where(chaveBusca, isEqualTo: emailUsuarioLogado)
        .get();

    List<Map<String, String?>> dataList = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return {
        'contactOwner': data['contactOwner'] as String?,
        'nameOfPerson': data['nameOfPerson'] as String?,
        'urlImage': data['urlImage'] as String?,
        'keyRelationId': data['keyRelationId'] as String?,
        'emailContact': data['emailContact'] as String?
      };
    }).toList();
    return dataList;
  }

  void _excluirDocumento(String documentId) async {
    try {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('notificacaoNovoContato')
          .doc(documentId);

      await documentReference.delete();

      print('Documento excluído com sucesso!');
    } catch (e) {
      print('Erro ao excluir o documento: $e');
    }
  }
}
