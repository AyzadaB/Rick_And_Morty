import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/usecases/get_character_details.dart';
import 'package:rick_and_morty/presentation/bloc/character_details/character_details_event.dart';
import 'package:rick_and_morty/presentation/bloc/character_details/character_details_state.dart';

class CharacterDetailsBloc
    extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  final GetCharacterDetailsUsecase getCharacterDetailsUsecase;

  CharacterDetailsBloc(this.getCharacterDetailsUsecase)
    : super(CharacterDetailsLoading()) {
    on<LoadCharacterDetails>(_onLoadCharacterDetails);
  }

  Future<void> _onLoadCharacterDetails(
    LoadCharacterDetails event,
    Emitter<CharacterDetailsState> emit,
  ) async {
    try {
      emit(CharacterDetailsLoading());
      final character = await getCharacterDetailsUsecase.execute(event.id);
      emit(CharacterDetailsSuccess(character)); // если хочешь список
    } catch (e) {
      emit(CharacterDetailsError(e.toString()));
    }
  }
}
