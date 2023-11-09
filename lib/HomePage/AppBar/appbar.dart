import 'package:clone_whatsapp/Utils/textUtil.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _MyAppBarState extends State<MyAppBar> {
  Color primaryColor = const Color(0xff2a068f);
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
              const PopupMenuItem<String>(
                value: 'opcao1',
                child: Row(children: [
                  Icon(Icons.account_circle, color: Colors.white),
                  MyTextFormat(message: 'Perfil', color: Colors.white),
                ]),
              ),
              const PopupMenuItem<String>(
                value: 'opcao2',
                child: Row(children: [
                  Icon(Icons.exit_to_app, color: Colors.red),
                  MyTextFormat(message: 'Sair', color: Colors.red)
                ]),
              ),
            ],
            icon: Icon(Icons.more_vert, color: Colors.white),
            color: primaryColor,
            surfaceTintColor: Colors.white,
            elevation: 0,
            position: PopupMenuPosition.under,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }

  Size getPreferredSize() {
    final tabBarSize = TabBar(tabs: []).preferredSize;
    final appBarSize = AppBar().preferredSize;
    return Size(tabBarSize.width + appBarSize.width,
        tabBarSize.height + appBarSize.height);
  }
}
//
// class TopBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'WhatsApp',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           Row(
//             children: [
//               IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: () {
//                   // Implementar ação de pesquisa
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.more_vert),
//                 onPressed: () {
//                   // Implementar ação de mais opções
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
