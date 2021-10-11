class AppData {
  bool firstStartUp;
  String currentUser;
  String iD;

  AppData({this.firstStartUp, this.currentUser, this.iD});

  Map<String, dynamic> toMap() {
    return {'firstStartUp': firstStartUp, 'currentUser': currentUser};
  }
}
