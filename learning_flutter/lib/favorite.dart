import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    if (appState.favorites.isEmpty) {
      return Center(
        child: Text(
          "No favorites yet",
        ),
      );
    }
    return (
      ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "You have ${appState.favorites.length} favorites :",
          ),
        ),
        for(var favorite in appState.favorites)
          ListTile(
            title: Text(favorite.asPascalCase),
            leading: Icon(Icons.favorite),
            ),
      ],
    ));
  }
}