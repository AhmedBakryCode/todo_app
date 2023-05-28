import 'dart:convert';

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;
  Task({
    this.id,
    this.title,
    this.note,
    this.repeat,
    this.color,
    this.endTime,
    this.startTime,
    this.date,
    this.isCompleted,
    this.remind,

  } );
  Map<String,dynamic> tojson(){
    return{
      'id':id,
      "title":title,
      "note":note,
      "isCompleted":isCompleted,
      "date":date,
      "startTime":startTime,
      "endTime":endTime,
      "remind":remind,
      "repeat":repeat,
      "color":color,
    };

  }
   Task.fromjson(Map<String,dynamic> json){
      id=json["id"];
      title=json["title"];
      note=json["note"];
      repeat=json["repeat"];
      color=json["color"];
      endTime=json["endTime"];
      startTime=json["startTime"];
      date=json["date"];
      isCompleted=json["isCompleted"];
      remind=json["remind"];



  }

}
