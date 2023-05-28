import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version=1;
  static final String _tablename='tasks';
  
  static Future<void> initDb()async{
    
    if(_db!=null){
      debugPrint("not nll Db");
      return;
    }
    else{
      try{
        String _path=await getDatabasesPath()+"tasks.db";
        _db=await openDatabase(_path,version: _version,onCreate:(Database db,int version)async{
          print("Creating a new Db");
          await db.execute("""
          Create Table $_tablename(
        id  integer primary key autoincrement,
        title STRING ,
        note TEXT,
        date STRING,
        startTime STRING,
        endTime STRING,
        remind integer, 
        repeat STRING,
        color integer, 
        isCompleted INTEGER)
              """
          ,

          );
        } );
      }
      catch(e){
        print(e);
      }
      
    }

  }
  static Future<int>insert (Task? task)async{
    print("insert");
    try{
    return await _db!.insert(_tablename, task!.tojson());
  }catch(e){
      print(e);
      return 30000;
    }

  }

  static Future<int>deleteAll()async{
    print("delete");
    return await _db!.delete(_tablename);
  }

  static Future<int>delete (Task? task)async{
    print("delete");
    return await _db!.delete(_tablename,where: "id=?",whereArgs: [task?.id]);
  }
  static Future<int?>Update (id)async{
    print("Update");
    return await _db?.rawUpdate("""
    UPDATE tasks
    SET isCompleted =?
    WHERE id=?
    
""",[1,id]);
  }
  static Future<List<Map<String,dynamic>>> Query()async{
    print("Query");
    return await _db!.query(_tablename);
  }
}
