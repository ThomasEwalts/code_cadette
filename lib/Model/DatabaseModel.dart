import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:code_cadette/Model/DatabaseClasses/DatabaseClassLibrary.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:io';

class DatabaseModel {
  static var _path;
  static var _databasesPath;

  DatabaseModel._privateConstructor();
  static final DatabaseModel instance = DatabaseModel._privateConstructor();

  static Future<void> setDatabase() async {
    _databasesPath = await getDatabasesPath();
    _path = join(_databasesPath, "code_cadette_database.db");

    // Check if the database exists
    var exists = await databaseExists(_path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(_path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle
          .load(join("assets", "database", "code_cadette_database.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(_path).writeAsBytes(bytes, flush: true);
    }
  }


  static Future<Leerdoel> getLeerDoel(int id) async {
    Database db = await openDatabase(_path);

    final List<Map<String, dynamic>> maps =
        await db.query('Leerdoel', where: "id = $id");

    db.close();

    Leerdoel leerdoel = Leerdoel(
        id: maps[0]['id'],
        name: maps[0]['name'],
        explanation: maps[0]['explanation']);

    return leerdoel;
  }



  static Future<Vraag> getVraag(int id) async {
    Database db = await openDatabase(_path);

    final List<Map<String, dynamic>> maps =
        await db.query('Vraag', where: "id = $id");

    db.close();

    Vraag vraag = Vraag(
        id: maps[0]['id'],
        leerdoelId: maps[0]['leerdoelId'],
        vraagtypeKeyboard: maps[0]['vraagtypeKeyboard'],
        vraagtekst: maps[0]['vraagtekst']);

    return vraag;
  }



  static Future<List<Antwoord>> getAntwoordList(int id) async {
    Database db = await openDatabase(_path);

    final List<Map<String, dynamic>> maps =
        await db.query('Antwoord', where: "vraagId = $id");

    db.close();

    List<Antwoord> antwoord = List.generate(maps.length, (i) {
      return Antwoord(
          id: maps[i]['id'],
          vraagId: maps[i]['vraagId'],
          positie: maps[i]['positie'],
          antwoord: maps[i]['antwoord'].toString(),
          filledIn: maps[i]['filledIn'] == 1 ? true : false);
    });

    return antwoord;
  }
}
