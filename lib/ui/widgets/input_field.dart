import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
     this.widget,
    required this.obscureText,
    required this.prefix,
    required this.suffix,
  }) : super(key: key);
  final String? title;
  final bool? obscureText;
  final String? hint;
  final Icon? prefix;
  final Icon? suffix;

  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title!,
            style: titlestyle,
          ),
          Container(
            padding: EdgeInsets.only(left: 14),
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.grey)
            ),
            width: SizeConfig.screenWidth,
            height: 52,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(readOnly: widget!=null?true:false,
                    autofocus: false,
                    cursorColor: Get.isDarkMode? Colors.grey[100]:Colors.grey[700],
                    obscureText: obscureText!,
                    controller: controller,
style: subTitlestyle,
                    decoration: InputDecoration(
                        prefixIcon: prefix,
                        suffixIcon: suffix,
                        hintText: hint,

                        hintStyle: subTitlestyle,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: context.theme.backgroundColor),
                        ),focusedBorder:UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context.theme.backgroundColor),
                    ) ,

                    ),
                  ),
                ),
               Container(child: widget,) ,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
