// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Top10 {
  String? category;
  List<Top10List>? list;
  Top10({
    this.category,
    this.list,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'list': list?.map((x) => x.toMap()).toList(),
    };
  }

  factory Top10.fromMap(Map<String, dynamic> map) {
    return Top10(
      category: map['category'] != null ? map['category'] as String : null,
      list: map['list'] != null
          ? List<Top10List>.from(
              (map['list'] as List<int>).map<Top10List?>(
                (x) => Top10List.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Top10.fromJson(String source) =>
      Top10.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Top10List {
  int? position;
  String? id;
  String? name;
  int? favorites;
  Top10List({
    this.position,
    this.id,
    this.name,
    this.favorites,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'position': position,
      'id': id,
      'name': name,
      'favorites': favorites,
    };
  }

  factory Top10List.fromMap(Map<String, dynamic> map) {
    return Top10List(
      position: map['position'] != null ? map['position'] as int : null,
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      favorites: map['favorites'] != null ? map['favorites'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Top10List.fromJson(String source) =>
      Top10List.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SearchDevice {
  String? id;
  String? name;
  String? img;
  String? description;
  SearchDevice({
    this.id,
    this.name,
    this.img,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'img': img,
      'description': description,
    };
  }

  factory SearchDevice.fromMap(Map<String, dynamic> map) {
    return SearchDevice(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      img: map['img'] != null ? map['img'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchDevice.fromJson(String source) =>
      SearchDevice.fromMap(json.decode(source) as Map<String, dynamic>);
}

class QuickSpec {
  String? name;
  String? value;
  QuickSpec({
    this.name,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
    };
  }

  factory QuickSpec.fromMap(Map<String, dynamic> map) {
    return QuickSpec(
      name: map['name'] != null ? map['name'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuickSpec.fromJson(String source) =>
      QuickSpec.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DetailSpec {
  String? category;
  List<Specifications>? specifications;
  DetailSpec({
    this.category,
    this.specifications,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'specifications': specifications!.map((x) => x.toMap()).toList(),
    };
  }

  factory DetailSpec.fromMap(Map<String, dynamic> map) {
    return DetailSpec(
      category: map['category'] != null ? map['category'] as String : null,
      specifications: map['specifications'] != null
          ? List<Specifications>.from(
              (map['specifications'] as List<int>).map<Specifications?>(
                (x) => Specifications.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailSpec.fromJson(String source) =>
      DetailSpec.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Specifications {
  String? name;
  String? value;
  Specifications({
    this.name,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
    };
  }

  factory Specifications.fromMap(Map<String, dynamic> map) {
    return Specifications(
      name: map['name'] != null ? map['name'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Specifications.fromJson(String source) =>
      Specifications.fromMap(json.decode(source) as Map<String, dynamic>);
}
