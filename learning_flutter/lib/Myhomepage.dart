import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'favorite.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var slectedIndex = 1;
  @override
  Widget build(BuildContext context) {
  Widget page;
    switch (slectedIndex) {
      case 0:
        page = HomeGeneratorPage();
      case 1:
        page = FavoritePage();
      default:
        throw UnimplementedError('no widget for $slectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: false,//constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: slectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      slectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class HomeGeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Love(appState: appState, icon: icon),
        ],
      ),
    );
  }
}

// ...

class Love extends StatelessWidget {
  const Love({
    super.key,
    required this.appState,
    required this.icon,
  });

  final MyAppState appState;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            appState.toggleFavorite();
          },
          icon: Icon(icon),
          label: Text('Like'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            appState.getNext();
          },
          child: Text('Next'),
        ),
      ],
    );
  }
}

class BigCard extends StatelessWidget {
  final WordPair pair;

  const BigCard({required this.pair, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),

        // ↓ Make the following change.
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
