import 'package:equatable/equatable.dart';

abstract class CharacterListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCharacters extends CharacterListEvent {
  final int page;

  LoadCharacters({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class LoadCharacterById extends CharacterListEvent {
  final String id;

  LoadCharacterById(this.id);

  @override
  List<Object?> get props => [];
}
