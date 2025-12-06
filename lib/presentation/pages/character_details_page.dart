import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/bloc/character_details/character_details_bloc.dart';
import 'package:rick_and_morty/presentation/bloc/character_details/character_details_event.dart';
import '../bloc/character_details/character_details_state.dart';

class CharacterDetailsPage extends StatefulWidget {
  final String id;

  const CharacterDetailsPage({super.key, required this.id});

  @override
  CharacterDetailsPageState createState() => CharacterDetailsPageState();
}

class CharacterDetailsPageState extends State<CharacterDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<CharacterDetailsBloc>().add(LoadCharacterDetails(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
          builder: (context, state) {
            if (state is CharacterDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is CharacterDetailsSuccess) {
              final character = state.character;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      character.image,
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            character.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("Status: ${character.status}"),
                          Text("Gender: ${character.gender}"),
                          Text("Species: ${character.species}"),
                          Text("Origin: ${character.origin}"),
                          Text("Location: ${character.location}"),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is CharacterDetailsError) {
              return Center(child: Text(state.error ?? "Error"));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
