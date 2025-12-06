import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/data/datasources/character_remote_datasource.dart';
import 'package:rick_and_morty/data/repositories/character_repository_impl.dart';
import 'package:rick_and_morty/domain/repository/character_repository.dart';
import 'package:rick_and_morty/domain/usecases/get_character_details.dart';
import 'package:rick_and_morty/domain/usecases/get_characters.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<CharacterRemoteDatasource>(
    () => CharacterRemoteDatasource(dio: sl()),
  );

  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetCharactersUsecase>(
    () => GetCharactersUsecase(sl()),
  );

  sl.registerLazySingleton<GetCharacterDetailsUsecase>(
    () => GetCharacterDetailsUsecase(sl()),
  );
}
