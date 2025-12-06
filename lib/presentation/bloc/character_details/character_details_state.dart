import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/domain/entity/character_entity.dart';

abstract class CharacterDetailsState extends Equatable {
  const CharacterDetailsState();

  @override
  List<Object?> get props => [];
}

class CharacterDetailsLoading extends CharacterDetailsState {}

class CharacterDetailsSuccess extends CharacterDetailsState {
  final CharacterEntity character;

  const CharacterDetailsSuccess(this.character);

  CharacterDetailsSuccess copyWith({CharacterEntity? character}) {
    return CharacterDetailsSuccess(character ?? this.character);
  }

  @override
  List<Object?> get props => [character];
}

class CharacterDetailsError extends CharacterDetailsState {
  final String? error;

  const CharacterDetailsError(this.error);

  @override
  List<Object?> get props => [error];
}
