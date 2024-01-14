import 'package:flutter/material.dart';
import 'package:clone_whatsapp/Pages/Auth/Login.dart';
import 'package:clone_whatsapp/Pages/HomePage/AppBar/SettingsPage/Searching/Searching.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String fotoUsuarioLogado;

  MyAppBar({super.key, required this.fotoUsuarioLogado});

  @override
  _MyAppBarState createState() =>
      _MyAppBarState(fotoUsuarioLogado: fotoUsuarioLogado);

  @override
  Size get preferredSize => getPreferredSize();

  Size getPreferredSize() {
    final tabBarSize = TabBar(tabs: []).preferredSize;
    final appBarSize = AppBar().preferredSize;
    return Size(tabBarSize.width + appBarSize.width,
        tabBarSize.height + appBarSize.height);
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;

void signOutUser(BuildContext context) async {
  try {
    await auth.signOut().then((value) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login())));
  } catch (e) {
    print("Erro ao deslogar: $e");
  }
}

class _MyAppBarState extends State<MyAppBar> {
  Color primaryColor = const Color(0xff128c7e);
  Color navbarSelectedColor = const Color(0xff25d366);
  bool isSearching = false;
  final String fotoUsuarioLogado;

  _MyAppBarState({required this.fotoUsuarioLogado});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Searching(isSearching, onSearchChanged: (value) {
        setState(() {
          isSearching = value;
        });
      }),
      backgroundColor: primaryColor,
      actions: [
        IconButton(
          icon: Icon(isSearching ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              isSearching = !isSearching;
            });
          },
        ),
        Container(
          child: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'exit') {
                signOutUser(context);
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'exit',
                child: Row(children: [
                  Icon(Icons.exit_to_app, color: Colors.red),
                  SizedBox(width: 6),
                  Text('Sair', style: TextStyle(color: Colors.red)),
                ]),
              ),
            ],
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Hero(
                tag: fotoUsuarioLogado,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(fotoUsuarioLogado),
                ),
              ),
            ),
            color: primaryColor,
            elevation: 0,
            position: PopupMenuPosition.under,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
      bottom: TabBar(
        indicatorColor: navbarSelectedColor,
        labelColor: navbarSelectedColor,
        unselectedLabelColor: Colors.white54,
        indicatorWeight: 2.5,
        tabs: [
          Tab(text: 'Conversas'),
          Tab(text: 'Atualizações'),
          Tab(text: 'Chamadas'),
        ],
      ),
    );
  }
}
