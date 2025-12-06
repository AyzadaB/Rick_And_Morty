import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/usecases/get_character_details.dart';
import 'package:rick_and_morty/injection_container.dart';
import 'package:rick_and_morty/presentation/bloc/character_details/character_details_bloc.dart';
import 'package:rick_and_morty/presentation/bloc/character_list/character_list_bloc.dart';
import 'package:rick_and_morty/presentation/bloc/character_list/character_list_event.dart';
import 'package:rick_and_morty/presentation/bloc/character_list/character_list_state.dart';
import 'package:rick_and_morty/presentation/pages/character_details_page.dart';
import 'package:rick_and_morty/presentation/widgets/gender_widget.dart';
import 'package:rick_and_morty/presentation/widgets/status_widget.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  CharacterPageState createState() => CharacterPageState();
}

class CharacterPageState extends State<CharacterPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Первое событие
    context.read<CharacterListBloc>().add(LoadCharacters(page: 1));

    // Слушатель для пагинации
    _scrollController.addListener(() {
      final bloc = context.read<CharacterListBloc>();

      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !bloc.hasReachedMax) {
        bloc.add(LoadCharacters(page: bloc.currentPage + 1));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Character List",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<CharacterListBloc, CharacterListState>(
        builder: (context, state) {
          if (state is CharactersLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CharactersSuccess) {
            final characters = state.characters;
            return GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: characters.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 3 columns
                crossAxisSpacing: 7.0,
                mainAxisSpacing: 7.0,
              ),
              itemBuilder: (context, index) {
                if (index == state.characters.length) {
                  return _buildLoader();
                }
                final character = characters[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => CharacterDetailsBloc(
                            sl<GetCharacterDetailsUsecase>(),
                          ),
                          child: CharacterDetailsPage(id: character.id),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 115, 122, 154),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          Image.network(
                            character.image,
                            height: 100,
                            width: 170,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            character.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 3),
                          heartStatus(character.status),
                          genderStatus(character.gender),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          if (state is CharactersError) {
            return Center(child: Text(state.error ?? "Error"));
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildLoader() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
