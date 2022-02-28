class CrewModel {
  String? type;
  Person? person;

  CrewModel({this.type, this.person});

  CrewModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    person =
        json['person'] != null ? new Person.fromJson(json['person']) : null;
  }
}

class Person {
  int? id;
  String? name;
  Image? image;

  Person({this.id, this.name, this.image});

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }
}

class Image {
  String? medium;
  String? original;

  Image({this.medium, this.original});

  Image.fromJson(Map<String, dynamic> json) {
    medium = json['medium'];
    original = json['original'];
  }
}
