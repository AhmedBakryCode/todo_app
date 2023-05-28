import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:todo/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  final String paylod;

  const NotificationScreen({Key? key, required this.paylod}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _paylod = " ";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paylod = widget.paylod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        title: Text(
          _paylod.toString().split('|')[0],
          style: TextStyle(color: Get.isDarkMode ? Colors.white : darkGreyClr,fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text(

              "Hello Hassan",
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : darkGreyClr,
                  fontSize: 26,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "We are anew reminder",
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15),color: primaryClr),
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.text_format_outlined,color: Colors.white,size: 20,),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Title",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        )
                      ],
                    ),
                    Text(_paylod.toString().split("|")[0],style: TextStyle(color: Colors.white,fontSize: 20),),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        Icon(Icons.description,color: Colors.white,size: 20,),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        )
                      ],
                    ),
                    Text(_paylod.toString().split("|")[1],style: TextStyle(color: Colors.white,fontSize: 20)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined,color: Colors.white,size: 20,),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Date",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        )
                      ],
                    ),
                    Text(_paylod.toString().split("|")[2],style: TextStyle(color: Colors.white,fontSize: 20)),


                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
