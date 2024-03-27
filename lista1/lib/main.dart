import 'package:flutter/material.dart';
import 'first_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      routes: {
        '/first': (context) => FirstScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _displayText = 'Texto Inicial';

  void _changeText() {
    setState(() {
      _displayText = 'Novo Texto';
    });
  }

  void _navigateToFirstScreen() {
    Navigator.pushNamed(context, '/first');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercício 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _displayText,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeText,
              child: Text('Mudar Texto'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToFirstScreen,
              child: Text('Ir para a Tela First'),
            ),
          ],
        ),
      ),
    );
  }
}
