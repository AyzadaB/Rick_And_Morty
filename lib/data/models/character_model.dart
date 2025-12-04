import 'package:rick_and_morty/domain/entity/character_entity.dart';

class CharacterModel {
  final String? id;
  final String? image;
  final String? name;
  final String? status;
  final String? species;
  final String? gender;
  final String? originName;
  final String? locationName;

  // Именованный конструктор с nullable полями
  CharacterModel({
    this.id,
    this.image,
    this.name,
    this.status,
    this.species,
    this.gender,
    this.originName,
    this.locationName,
  });

  // fromJson - парсинг JSON от API
  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id']?.toString(),
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      image: json['image'],
      originName: json['origin']?['name'],
      locationName: json['location']?['name'],
    );
  }

  CharacterEntity toEntity() {
    return CharacterEntity(
      id: id ?? '',
      name: name ?? '',
      status: status ?? '',
      species: species ?? '',
      gender: gender ?? '',
      image: image ?? '',
      origin: originName ?? '',
      location: locationName ?? '',
    );
  }
}
