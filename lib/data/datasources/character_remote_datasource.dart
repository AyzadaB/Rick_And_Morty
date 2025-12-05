import 'package:dio/dio.dart';

class CharacterRemoteDatasource {
  final Dio dio;

  CharacterRemoteDatasource({required this.dio});

  Future<Response> getCharacters(int page) async {
    return await dio.get(
      'https://rickandmortyapi.com/api/character?page=$page',
    );
  }

  Future<Response> getCharactersById(String id) async {
    return await dio.get("https://rickandmortyapi.com/api/character/$id");
  }
}
