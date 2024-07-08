class Unit {
  int? id;
  String? name;

  Unit({this.id, this.name});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      name: json['name'],
    );
  }
}
