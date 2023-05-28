import 'package:flutter/material.dart';
import 'package:todo/ui/theme.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.label,required this.onTap}) : super(key: key);
final String label;
final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: primaryClr,
        ),
        height: 45,
        width: 100,
        alignment: Alignment.center,
child: Text(label,style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),
      ),
    );
  }
}
