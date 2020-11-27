import 'package:flutter/material.dart';
import 'package:indglobalyomess/utils/Constant.dart';

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
        boxShadow: [
          BoxShadow(
            color: this.color.withOpacity(0.4),
            blurRadius: 40,
            offset: Offset(0, 15),
          ),
          BoxShadow(
            color: this.color.withOpacity(0.4),
            blurRadius: 13,
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: FlatButton(
        onPressed: this.onPressed,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        color: color,
        shape: StadiumBorder(),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
