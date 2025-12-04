import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/repository/character_repository.dart';
import 'character_list_event.dart';
import 'character_list_state.dart';

class CharactersBloc extends Bloc<CharacterListEvent, CharacterListState> {
  final CharacterRepository repository;

  int currentPage = 1;
  bool hasReachedMax = false;

  CharactersBloc(this.repository) : super(CharactersLoading()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<LoadCharacterById>(_onLoadCharacterById);
  }

  Future<void> _onLoadCharacters(
    LoadCharacters event,
    Emitter<CharacterListState> emit,
  ) async {
    if (hasReachedMax) return;

    final currentState = state;

    try {
      if (currentState is CharactersSuccess && event.page > 1) {
        final newCharacters = await repository.getCharacters(page: event.page);

        if (newCharacters.isEmpty) {
          hasReachedMax = true;
        }

        emit(
          currentState.copyWith(
            characters: [...currentState.characters, ...newCharacters],
          ),
        );
      } else {
        emit(CharactersLoading());
        final characters = await repository.getCharacters(page: event.page);
        emit(CharactersSuccess(characters));
      }

      currentPage = event.page;
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }

  Future<void> _onLoadCharacterById(
    LoadCharacterById event,
    Emitter<CharacterListState> emit,
  ) async {
    try {
      emit(CharactersLoading());
      final character = await repository.getCharacterById(event.id);
      emit(CharactersSuccess([character]));
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }
}
