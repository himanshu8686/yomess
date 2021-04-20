import 'package:flutter/material.dart';
import 'package:indglobalyomess/utils/constant.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key key,
    @required this.color,
    @required this.text,
    @required this.onPressed,
  });

  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 30,
              spreadRadius: -16,
              offset: Offset(0, 5),
            )
          ]),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: this.onPressed,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        color: color,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
