import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final String id;
  final String image;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String origin;
  final String location;

  const CharacterEntity({
    required this.species,
    required this.gender,
    required this.origin,
    required this.location,
    required this.id,
    required this.image,
    required this.name,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    image,
    name,
    status,
    species,
    gender,
    origin,
    location,
  ];
}
