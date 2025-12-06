import 'package:equatable/equatable.dart';

abstract class CharacterDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCharacterDetails extends CharacterDetailsEvent {
  final String id;

  LoadCharacterDetails(this.id);

  @override
  List<Object?> get props => [id];
}
