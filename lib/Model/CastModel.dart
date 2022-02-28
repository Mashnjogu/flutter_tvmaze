class CastModel {
  Person? person;
  Character? character;

  CastModel({this.person, this.character});

  CastModel.fromJson(Map<String, dynamic> json) {
    person = json['person'] != null ? Person.fromJson(json['person']) : null;
    character = json['character'] != null
        ? Character.fromJson(json['character'])
        : null;
  }
}

class Person {
  int? id;
  String? name;
  Image? image;

  Person({
    this.id,
    this.name,
    this.image,
  });

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }
}

class Character {
  int? id;
  String? characterName;
  Image? image;

  Character({this.id, this.characterName, this.image});

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    characterName = json['name'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
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
