import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// Random Words | Stateful
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {

  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Gen'),
        actions: <Widget>[
          IconButton(
            icon : const Icon(Icons.list),
            onPressed: pushSaved
          )
        ],
      ),
      body: buildSuggestions()
    );
  }

  Widget buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/2;
        if(index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return buildRow(_suggestions[index]);
      });  
  }

  Widget buildRow(WordPair pair){

    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text (
        pair.asPascalCase,
        style: _biggerFont
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
            print(_saved);
          }
        });
      }, 
    );
  }

  void pushSaved(){
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext contect) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text (
                  pair.asPascalCase,
                  style: _biggerFont
                )
              );
            }
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Save Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        }
      )
    );
  }
}
