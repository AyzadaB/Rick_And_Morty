import 'package:flutter/material.dart';
import 'package:rick_and_morty/domain/entity/character_entity.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
    required this.character,
    required this.leading,
    required this.trailing,
  });

  final CharacterEntity character;
  final String leading;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(leading),
      trailing: Text(trailing),
      leadingAndTrailingTextStyle: TextStyle(fontSize: 25, color: Colors.black),
    );
  }
}
