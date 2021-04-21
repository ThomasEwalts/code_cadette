class Vraag {
  int id;
  int leerdoelId;
  int vraagtypeKeyboard;
  String vraagtekst;

  Vraag({this.id, this.leerdoelId, this.vraagtypeKeyboard, this.vraagtekst});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'leerdoelId': leerdoelId,
      'vraagtypeKeyboard': vraagtypeKeyboard,
      'vraagtekst': vraagtekst
    };
  }
}
