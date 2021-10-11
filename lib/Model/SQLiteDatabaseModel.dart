import 'package:code_cadette/Model/DatabaseModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:code_cadette/Model/DatabaseClasses/DatabaseClassLibrary.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:io';

class SQLiteDatabaseModel implements DatabaseModel {
  static var _path;
  static var _databasesPath;

  SQLiteDatabaseModel();

  Future<bool> setDatabase() async {
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

      return true;
    }

    return true;
  }

  Future<Leerdoel> getLeerDoel(int id) async {
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

  Future<Vraag> getVraag(int id) async {
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

  Future<List<Vraag>> getVraagListForLeerdoel(int id) async {
    Database db = await openDatabase(_path);

    final List<Map<String, dynamic>> maps =
        await db.query('Vraag', where: "leerdoelId = $id");

    db.close();

    List<Vraag> vragen = List.generate(maps.length, (i) {
      return Vraag(
          id: maps[i]['id'],
          leerdoelId: maps[i]['leerdoelId'],
          vraagtypeKeyboard: maps[i]['vraagtypeKeyboard'],
          vraagtekst: maps[i]['vraagtekst']);
    });

    return vragen;
  }

  Future<List<Antwoord>> getAntwoordList(int id) async {
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

  Future<AppData> getAppData() async {
    Database db = await openDatabase(_path);
    final List<Map<String, dynamic>> maps = await db.query('AppData');

    db.close();

    AppData appData = AppData(
        currentUser: maps[0]['currentUser'],
        firstStartUp: maps[0]['firstStartUp'] == 1 ? true : false);

    return appData;
  }

  Future<void> setFirstStartUp(bool setValue) async {
    Database db = await openDatabase(_path);
    await db.update('AppData', {'firstStartUp': setValue});
  }

  Future<void> setCurrentUser(String id) async {
    Database db = await openDatabase(_path);
    await db.update('AppData', {'currentUser': id});
  }

  Future<void> createUser(User user) async {
    Database db = await openDatabase(_path);

    await db.insert('User', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<User> getUser(String id) async {
    Database db = await openDatabase(_path);

    final List<Map<String, dynamic>> maps =
        await db.query('User', where: "id = $id");

    db.close();

    User user = User(
        id: maps[0]['id'],
        name: maps[0]['name'],
        alsDanPosition: maps[0]['alsDanPosition'],
        binairPosition: maps[0]['binairPosition'],
        alsDanPercentage: maps[0]['alsDanPercentage'],
        binairPercentage: maps[0]['binairPercentage']);

    return user;
  }

  Future<User> getCurrentUser() async {
    Database db = await openDatabase(_path);

    final List<Map<String, dynamic>> appDataMaps = await db.query('AppData');

    AppData appData = AppData(
        currentUser: appDataMaps[0]['currentUser'],
        firstStartUp: appDataMaps[0]['firstStartup']);

    final List<Map<String, dynamic>> userMap =
        await db.query('User', where: "id = '${appData.currentUser}'");

    db.close();

    User user = User(
        id: userMap[0]['id'],
        name: userMap[0]['name'],
        alsDanPosition: userMap[0]['alsDanPosition'],
        binairPosition: userMap[0]['binairPosition'],
        alsDanPercentage: userMap[0]['alsDanPercentage'],
        binairPercentage: userMap[0]['binairPercentage']);

    return user;
  }

  Future<void> updateUser(User user) async {
    Database db = await openDatabase(_path);

    await db
        .update('User', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }
}

DatabaseModel getDatabaseModel() => SQLiteDatabaseModel();
