import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/usecases/get_character_details.dart';
import 'package:rick_and_morty/domain/usecases/get_characters.dart';
import 'character_list_event.dart';
import 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  final GetCharactersUsecase getCharactersUsecase;
  final GetCharacterDetailsUsecase getCharacterDetailsUsecase;

  int currentPage = 1;
  bool hasReachedMax = false;

  CharacterListBloc(this.getCharactersUsecase, this.getCharacterDetailsUsecase)
    : super(CharactersLoading()) {
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
        final newCharacters = await getCharactersUsecase.execute(
          page: event.page,
        );

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
        final characters = await getCharactersUsecase.execute(page: event.page);
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
      final character = await getCharacterDetailsUsecase.execute(event.id);
      emit(CharactersSuccess([character]));
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }
}
