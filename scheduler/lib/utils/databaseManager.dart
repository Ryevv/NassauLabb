
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

import 'courseModel.dart';
class databaseManager{
  final String code='code';
   Database? _database;

  Future<Database?> get getDatabase async{
    if(_database!=null){
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }
  initDatabase()async{
    io.Directory documentDirectory =await getApplicationSupportDirectory();
    String path= join(documentDirectory.path,'coursesDatabase.db');
    WidgetsFlutterBinding.ensureInitialized();
    var database=await openDatabase(path, version:1,onCreate:_onCreate );
    return database;
  }
  _onCreate(Database database,int version )async{
    await database.execute(
      "CREATE TABLE Segunda (id INTEGER PRIMARY KEY AUTOINCREMENT,$code TEXT NOT NULL,name TEXT NOT NULL,time TEXT NOT NULL,hour TEXT NOT NULL,min TEXT NOT NULL,venue TEXT NOT NULL)"
    );
    await database.execute(
        "CREATE TABLE Terça (id INTEGER PRIMARY KEY AUTOINCREMENT,$code TEXT NOT NULL,name TEXT NOT NULL,time TEXT NOT NULL,hour TEXT NOT NULL,min TEXT NOT NULL,venue TEXT NOT NULL)"
    );
    await database.execute(
        "CREATE TABLE Quarta (id INTEGER PRIMARY KEY AUTOINCREMENT,$code TEXT NOT NULL,name TEXT NOT NULL,time TEXT NOT NULL,hour TEXT NOT NULL,min TEXT NOT NULL,venue TEXT NOT NULL)"
    );
    await database.execute(
        "CREATE TABLE Quinta (id INTEGER PRIMARY KEY AUTOINCREMENT,$code TEXT NOT NULL,name TEXT NOT NULL,time TEXT NOT NULL,hour TEXT NOT NULL,min TEXT NOT NULL,venue TEXT NOT NULL)"
    );
    await database.execute(
        "CREATE TABLE Sexta (id INTEGER PRIMARY KEY AUTOINCREMENT,$code TEXT NOT NULL,name TEXT NOT NULL,time TEXT NOT NULL,hour TEXT NOT NULL,min TEXT NOT NULL,venue TEXT NOT NULL)"
    );
    await database.execute(
        "CREATE TABLE Sábado (id INTEGER PRIMARY KEY AUTOINCREMENT,$code TEXT NOT NULL,name TEXT NOT NULL,time TEXT NOT NULL,hour TEXT NOT NULL,min TEXT NOT NULL,venue TEXT NOT NULL)"
    );
    await database.execute(
        "CREATE TABLE Domingo (id INTEGER PRIMARY KEY AUTOINCREMENT,$code TEXT NOT NULL,name TEXT NOT NULL,time TEXT NOT NULL,hour TEXT NOT NULL,min TEXT NOT NULL,venue TEXT NOT NULL)"
    );
  }
  Future<Course> insert(Course course,String day) async{
    var dbClient= await getDatabase;
    if(dbClient!=null){
      await dbClient.insert('$day',course.toMap());

    }
    return course;
  }

  Future<List<Course>> getCourses(String day)async {
    Database? dbClient = await getDatabase;
    final List<Map<String, Object?>> queryResult;
    if (dbClient != null) {
      queryResult = await dbClient.query('$day');
      }
    else{
        print("NULL Database");
        queryResult=[];
      }

      return queryResult.map((e) => Course.fromMap(e)).toList();

  }
   Future<void> delete(String codeValue,String day) async {
     Database? dbClient = await getDatabase;
     if(dbClient!=null) {
       await dbClient.delete(day, where: '$code = ?', whereArgs: [codeValue]);
     }
   }

}