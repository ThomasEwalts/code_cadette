class User {
  int id;
  String name;
  int alsDanPosition;
  int binairPosition;
  int alsDanPercentage;
  int binairPercentage;

  User(
      {this.id,
      this.name,
      this.alsDanPosition = 0,
      this.binairPosition = 0,
      this.alsDanPercentage = 0,
      this.binairPercentage = 0});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'alsDanPosition': alsDanPosition,
      'binairPosition': binairPosition,
      'alsDanPercentage': alsDanPercentage,
      'binairPercentage': binairPercentage
    };
  }
}
