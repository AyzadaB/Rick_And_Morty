import 'package:dio/dio.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/domain/entity/character_entity.dart';
import 'package:rick_and_morty/domain/repository/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final Dio dio;

  CharacterRepositoryImpl(this.dio);

  @override
  Future<List<CharacterEntity>> getCharacters({int page = 1}) async {
    try {
      final response = await dio.get(
        'https://rickandmortyapi.com/api/character?page=$page',
      );

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
      final response = await dio.get(
        'https://rickandmortyapi.com/api/character/$id',
      );

      final model = CharacterModel.fromJson(response.data);

      return model.toEntity();
    } catch (e) {
      throw Exception('Failed to load character');
    }
  }
}
