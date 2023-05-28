import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/db/db_helper.dart';

import '../models/task.dart';

class TaskController extends GetxController{

 final RxList<Task> taskList=<Task>[].obs;



 Future addtask({Task? task}){
   return DBHelper.insert(task);

 }
  Future<void> getTasks() async{
   final List<Map<String, dynamic>>? tasks=await DBHelper.Query();
   taskList.assignAll(tasks!.map((data) =>Task.fromjson(data)).toList());

   }
 void deleteTask({Task? task})async{
    await DBHelper.delete(task);
getTasks();
 }
 void deleteAllTask()async{
   await DBHelper.deleteAll();
   getTasks();
 }

 void markTaskCompleted(int id)async{
   await DBHelper.Update(id);
   getTasks();

 }
}
