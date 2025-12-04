import 'package:rick_and_morty/domain/entity/character_entity.dart';
import 'package:rick_and_morty/domain/repository/character_repository.dart';

class GetCharacterDetailsUsecase {
  final CharacterRepository repository;

  GetCharacterDetailsUsecase(this.repository);

  Future<CharacterEntity> execute(String id) {
    return repository.getCharacterById(id);
  }
}
