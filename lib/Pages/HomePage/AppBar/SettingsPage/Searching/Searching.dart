import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clone_whatsapp/Utils/textUtil.dart';

class Searching extends StatefulWidget {
  final bool isSearching;
  final ValueChanged<bool> onSearchChanged;

  Searching(this.isSearching, {required this.onSearchChanged});

  @override
  State<StatefulWidget> createState() => _MySearchingState();

}

class _MySearchingState extends State<Searching> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      alignment: widget.isSearching ? Alignment.centerRight : Alignment.centerLeft,
      constraints: BoxConstraints(
        minWidth: widget.isSearching ? 200.0 : 0.0,
      ),
      child: widget.isSearching ? TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Digite um contato',
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onChanged: (value) {
          widget.onSearchChanged(true);
        },
      ): MyTextFormat(message: 'Whatsapp Clone',),
    );
  }

}