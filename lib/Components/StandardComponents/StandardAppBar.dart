import 'package:flutter/material.dart';

//Deze class bevat de standaard appbar die door de gehele applicatie zal worden gebruikt
class StandardAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final Color color;
  final bool showBackButton;

  StandardAppBar({Key key, 
  this.title, 
  this.color,
  this.showBackButton = true,
  })
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  _StandardAppBarState createState() => _StandardAppBarState();
}

class _StandardAppBarState extends State<StandardAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.color,
      title: Text(widget.title,
          style: TextStyle(fontFamily: 'NickelodeonNF', fontSize: 35.0)),
      centerTitle: true,
      automaticallyImplyLeading: widget.showBackButton,
      actions: <Widget>[
        IconButton(onPressed: null, icon: Icon(Icons.settings))
      ],
    );
  }
}
