import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/domain/entity/character_entity.dart';

abstract class CharacterListState extends Equatable {
  const CharacterListState();

  @override
  List<Object?> get props => [];
}

class CharactersLoading extends CharacterListState {}

class CharactersSuccess extends CharacterListState {
  final List<CharacterEntity> characters;

  const CharactersSuccess(this.characters);

  CharactersSuccess copyWith({List<CharacterEntity>? characters}) {
    return CharactersSuccess(characters ?? this.characters);
  }

  @override
  List<Object?> get props => [characters];
}

class CharactersError extends CharacterListState {
  final String? error;

  const CharactersError(this.error);

  @override
  List<Object?> get props => [error];
}
