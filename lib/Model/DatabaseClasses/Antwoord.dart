class Antwoord {
  int id;
  int vraagId;
  int positie;
  String antwoord;
  bool filledIn;

  Antwoord({this.id, this.vraagId, this.positie, this.antwoord, this.filledIn});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vraagId': vraagId,
      'positie': positie,
      'antwoord': antwoord
    };
  }
}
