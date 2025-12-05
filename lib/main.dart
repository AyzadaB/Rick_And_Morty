import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/datasources/character_remote_datasource.dart';
import 'package:rick_and_morty/data/repositories/character_repository_impl.dart';
import 'package:rick_and_morty/domain/usecases/get_character_details.dart';
import 'package:rick_and_morty/domain/usecases/get_characters.dart';
import 'package:rick_and_morty/presentation/bloc/character_list/character_list_bloc.dart';
import 'package:rick_and_morty/presentation/pages/character_page.dart';

void main() {
  final dio = Dio();
  final remote = CharacterRemoteDatasource(dio: dio);
  final repository = CharacterRepositoryImpl(remote);
  final getCharactersUsecase = GetCharactersUsecase(repository);
  final getCharacterDetailsUsecase = GetCharacterDetailsUsecase(repository);

  runApp(
    MyApp(
      getCharactersUsecase: getCharactersUsecase,
      getCharacterDetailsUsecase: getCharacterDetailsUsecase,
    ),
  );
}

class MyApp extends StatelessWidget {
  final GetCharactersUsecase getCharactersUsecase;
  final GetCharacterDetailsUsecase getCharacterDetailsUsecase;

  const MyApp({
    super.key,
    required this.getCharactersUsecase,
    required this.getCharacterDetailsUsecase,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CharacterListBloc(getCharactersUsecase, getCharacterDetailsUsecase),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const CharacterPage(),
      ),
    );
  }
}
