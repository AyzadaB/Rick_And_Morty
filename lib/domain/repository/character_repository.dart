import 'package:rick_and_morty/domain/entity/character_entity.dart';

abstract class CharacterRepository {
  Future<List<CharacterEntity>> getCharacters({int page = 1});
  Future<CharacterEntity> getCharacterById(String id);
}
