import 'package:rick_and_morty/data/datasources/character_remote_datasource.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/domain/entity/character_entity.dart';
import 'package:rick_and_morty/domain/repository/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDatasource remote;

  CharacterRepositoryImpl(this.remote);

  @override
  Future<List<CharacterEntity>> getCharacters({int page = 1}) async {
    try {
      final response = await remote.getCharacters(page);

      final results = response.data['results'] as List;

      return results
          .map((json) => CharacterModel.fromJson(json).toEntity())
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<CharacterEntity> getCharacterById(String id) async {
    try {
      final response = await remote.getCharactersById(id);

      final model = CharacterModel.fromJson(response.data);

      return model.toEntity();
    } catch (e) {
      throw Exception('Failed to load character');
    }
  }
}
