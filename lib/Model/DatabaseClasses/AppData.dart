class AppData {
  bool firstStartUp;
  int currentUser;

  AppData({this.firstStartUp, this.currentUser});

  Map<String, dynamic> toMap() {
    return {'firstStartUp': firstStartUp, 'currentUser': currentUser};
  }
}
