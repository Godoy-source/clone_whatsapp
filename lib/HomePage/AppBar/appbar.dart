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
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            // Implementar ação de mais opções
          },
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
      )
    );
  }
  Size getPreferredSize() {
    final tabBarSize = TabBar(tabs: []).preferredSize;
    final appBarSize = AppBar().preferredSize;
    return Size(tabBarSize.width + appBarSize.width, tabBarSize.height + appBarSize.height);
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