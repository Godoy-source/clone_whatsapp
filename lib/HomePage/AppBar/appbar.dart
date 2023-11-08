import 'package:clone_whatsapp/Utils/textUtil.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => _MyAppBarState().getPreferredSize();
}

class _MyAppBarState extends State<MyAppBar> {
  Color primaryColor = const Color(0xff128c7e);
  Color navbarSelectedColor = const Color(0xff25d366);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text('ZapZap.com.br'),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Adicione ação do ícone de pesquisa
            },
          ),
          Container(
            child: PopupMenuButton<String>(
              onSelected: (value) {
                // Implemente a lógica para cada item do menu selecionado
                print('Opção selecionada: $value');
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'opcao1',
                  child: Row(children: [
                    Icon(Icons.account_circle, color: Colors.white),
                    MyTextFormat(message: 'Perfil', color: Colors.white),
                  ]),
                ),
                PopupMenuItem<String>(
                  value: 'opcao2',
                  child: Row(children: [
                    Icon(Icons.exit_to_app, color: Colors.red),
                    MyTextFormat(message: 'Sair', color: Colors.red)
                  ]),
                ),
                // Adicione mais itens de menu conforme necessário
              ],
              icon: Icon(Icons.more_vert, color: Colors.white),
              color: primaryColor,
              surfaceTintColor: Colors.white,
              elevation: 0,
              position: PopupMenuPosition.under,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Borda arredondada
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
        ));
  }

  Size getPreferredSize() {
    final tabBarSize = TabBar(tabs: []).preferredSize;
    final appBarSize = AppBar().preferredSize;
    return Size(tabBarSize.width + appBarSize.width,
        tabBarSize.height + appBarSize.height);
  }
}
