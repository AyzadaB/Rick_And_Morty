import 'package:flutter/material.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  CharacterPageState createState() => CharacterPageState();
}

class CharacterPageState extends State<CharacterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Character List", style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          GridView.builder(
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 columns
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) {
              return Card(
                elevation: 4.0,
                child: Column(
                  children: [Image.network(''), Text("name"), Text("status")],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
