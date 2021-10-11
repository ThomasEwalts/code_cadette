import 'package:code_cadette/Model/DatabaseClasses/DatabaseClassLibrary.dart';
import 'DatabaseModelStub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'package:code_cadette/Model/SQLiteDatabaseModel.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'package:code_cadette/Model/FirebaseDatabaseModel.dart';

abstract class DatabaseModel {
  factory DatabaseModel() => getDatabaseModel();

  Future<bool> setDatabase();

  Future<Leerdoel> getLeerDoel(int id);

  Future<Vraag> getVraag(int id);

  Future<List<Vraag>> getVraagListForLeerdoel(int id);

  Future<List<Antwoord>> getAntwoordList(int id);

  Future<AppData> getAppData();

  Future<void> setFirstStartUp(bool setValue);

  Future<void> setCurrentUser(String id);

  Future<void> createUser(User user);

  Future<User> getUser(String id);

  Future<User> getCurrentUser();

  Future<void> updateUser(User user);
}
