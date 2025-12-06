import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/injection_container.dart';
import 'package:rick_and_morty/presentation/bloc/character_list/character_list_bloc.dart';
import 'package:rick_and_morty/presentation/pages/character_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CharacterListBloc(sl()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const CharacterPage(),
      ),
    );
  }
}
