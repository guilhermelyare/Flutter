import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FavoriteListScreen(),
    );
  }
}

class FavoriteListScreen extends StatefulWidget {
  @override
  _FavoriteListScreenState createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  List<String> _favorites = [];

  void _addFavorite(String item) {
    setState(() {
      _favorites.add(item);
    });
  }

  void _removeFavorite(String item) {
    setState(() {
      _favorites.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Favoritos')),
      body: ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          final item = _favorites[index];
          return ListTile(
            title: Text(item),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _removeFavorite(item);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _textController = TextEditingController();
        return AlertDialog(
          title: Text('Adicionar Item'),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(hintText: 'Nome do item'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final newItem = _textController.text.trim();
                if (newItem.isNotEmpty) {
                  _addFavorite(newItem);
                }
                Navigator.of(context).pop();
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
