import 'package:rick_and_morty/domain/entity/character_entity.dart';
import 'package:rick_and_morty/domain/repository/character_repository.dart';

class GetCharactersUsecase {
  final CharacterRepository repository;

  GetCharactersUsecase(this.repository);

  Future<List<CharacterEntity>> execute({int page = 1}) {
    return repository.getCharacters(page: page);
  }
}
