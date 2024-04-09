import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Previsão do Tempo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String cidade = 'Belo Jardim'; // Altere para sua cidade
  double temperatura = 0;
  String descricaoClima = '';
  String iconeClima = '';


  Future<void> _obterPrevisaoTempo() async {
    // API Key da OpenWeatherMap (obtenha a sua em https://openweathermap.org/appid)
    const String apiKey = 'c7f63978aeb1c8255f1763c82a70324d';
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final dados = json.decode(response.body);
      setState(() {
        temperatura = dados['main']['temp'] - 273.15; // Convertendo de Kelvin para Celsius
        descricaoClima = dados['weather'][0]['description'];
        iconeClima = dados['weather'][0]['icon'];
      });
    } else {
      print('Erro ao obter previsão do tempo: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previsão do Tempo em $cidade'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (temperatura != null)
              Text(
                'Temperatura: ${temperatura.toStringAsFixed(1)}°C',
                style: TextStyle(fontSize: 24),
              ),
            if (descricaoClima != null)
              Text(
                'Descrição: $descricaoClima',
                style: TextStyle(fontSize: 18),
              ),
            if (iconeClima != null)
              Image.network(
                'http://openweathermap.org/img/wn/$iconeClima@2x.png',
                width: 100,
                height: 100,
              ),
            ElevatedButton(
              onPressed: _obterPrevisaoTempo,
              child: Text('Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
