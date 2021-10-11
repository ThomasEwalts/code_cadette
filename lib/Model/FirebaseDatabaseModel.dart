import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_cadette/Model/DatabaseModel.dart';
import 'package:code_cadette/Model/DatabaseClasses/DatabaseClassLibrary.dart';

class FirebaseDatabaseModel implements DatabaseModel {
  static FirebaseFirestore _instance;
  static String _userId;
  static String _userAppData;

  FirebaseDatabaseModel();

  Future<bool> setDatabase() async {
    _instance = FirebaseFirestore.instance;
    _instance.enablePersistence(PersistenceSettings(synchronizeTabs: true));

    try {
      var maps = await _instance
          .collection('AppData')
          .get(GetOptions(source: Source.cache));
      var list = maps.docs;

      _userAppData = list[0].id;
      _userId = list[0]['currentUser'];
    } catch (e) {
      await _createAppData(AppData());
    }
    return true;
  }

  Future<Leerdoel> getLeerDoel(int id) async {
    var maps = await _instance.collection('Leerdoel').doc(id.toString()).get();

    Leerdoel leerdoel = Leerdoel(
        id: int.parse(maps.id),
        name: maps['name'],
        explanation: maps['explanation']);

    return leerdoel;
  }

  Future<Vraag> getVraag(int id) async {
    var maps = await _instance.collection('Vraag').doc(id.toString()).get();

    Vraag vraag = Vraag(
        id: int.parse(maps.id),
        leerdoelId: maps['leerdoelId'],
        vraagtypeKeyboard: maps['vraagtypeKeyboard'],
        vraagtekst: maps['vraagtekst']);

    return vraag;
  }

  Future<List<Vraag>> getVraagListForLeerdoel(int id) async {
    var maps = await _instance
        .collection('Vraag')
        .where('leerdoelId', isEqualTo: id)
        .get();

    var list = maps.docs;

    List<Vraag> vragen = List.generate(list.length, (i) {
      return Vraag(
          id: int.parse(list[i].id),
          leerdoelId: list[i]['leerdoelId'],
          vraagtypeKeyboard: list[i]['vraagtypeKeyboard'],
          vraagtekst: list[i]['vraagtekst']);
    });

    return vragen;
  }

  Future<List<Antwoord>> getAntwoordList(int id) async {
    var maps = await _instance
        .collection('Antwoord')
        .where('vraagId', isEqualTo: id)
        .get();

    var list = maps.docs;

    List<Antwoord> antwoord = List.generate(list.length, (i) {
      return Antwoord(
          id: int.parse(list[i].id),
          vraagId: list[i]['vraagId'],
          positie: list[i]['positie'],
          antwoord: list[i]['antwoord'].toString(),
          filledIn: list[i]['filledIn']);
    });

    return antwoord;
  }

  Future<AppData> getAppData() async {
    var maps = await _instance
        .collection('AppData')
        .doc(_userAppData)
        .get(GetOptions(source: Source.cache));

    AppData appData = AppData(
        currentUser: maps['currentUser'], firstStartUp: maps['firstStartUp']);

    return appData;
  }

  Future<void> setFirstStartUp(bool setValue) async {
    await _instance
        .collection('AppData')
        .doc(_userAppData)
        .update({'firstStartUp': false});
  }

  Future<void> setCurrentUser(String id) async {
    await _instance
        .collection('AppData')
        .doc(_userAppData)
        .update({'currentUser': id});
  }

  Future<void> createUser(User user) async {
    var newDoc = await _instance.collection('User').add({
      'name': user.name,
      'alsDanPosition': user.alsDanPosition,
      'binairPosition': user.binairPosition,
      'alsDanPercentage': user.alsDanPercentage,
      'binairPercentage': user.binairPercentage
    });

    await _instance
        .collection('AppData')
        .doc(_userAppData)
        .update({'currentUser': newDoc.id});

    _userId = newDoc.id;
  }

  Future<User> getUser(String id) async {
    var maps = await _instance.collection('User').doc(id.toString()).get();

    User user = User(
        id: maps[0]['ID'],
        name: maps[0]['name'],
        alsDanPosition: maps[0]['alsDanPosition'],
        binairPosition: maps[0]['binairPosition'],
        alsDanPercentage: maps[0]['alsDanPercentage'],
        binairPercentage: maps[0]['binairPercentage']);

    return user;
  }

  Future<User> getCurrentUser() async {
    var userMap = await _instance.collection('User').doc(_userId).get();

    User user = User(
        id: userMap.id,
        name: userMap['name'],
        alsDanPosition: userMap['alsDanPosition'],
        binairPosition: userMap['binairPosition'],
        alsDanPercentage: userMap['alsDanPercentage'],
        binairPercentage: userMap['binairPercentage']);
    return user;
  }

  Future<void> updateUser(User user) async {
    await _instance.collection('User').doc(_userId).update({
      'name': user.name,
      'alsDanPosition': user.alsDanPosition,
      'binairPosition': user.binairPosition,
      'alsDanPercentage': user.alsDanPercentage,
      'binairpercentage': user.binairPercentage
    });
  }

  Future<void> _createAppData(AppData appData) async {
    var _appDataDoc = await _instance
        .collection('AppData')
        .add({'firstStartUp': true, 'currentUser': ''});

    _userAppData = _appDataDoc.id;
  }
}

DatabaseModel getDatabaseModel() => FirebaseDatabaseModel();
