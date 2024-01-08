import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.amber,
        
      ),
      home: CurrencyConverter(),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  CurrencyConverter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  double amount = 0.0;
  String fromCurrency = 'USD';
  String toCurrency = 'EUR';
  double convertedAmount = 0.0;
  late TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: amount.toString());
  }

  void cambiarValorPrimerDropdown() {
    setState(() {
      String currencyTemp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = currencyTemp;

      double amountTemp = convertedAmount;
      convertedAmount = amount;
      amount = amountTemp;
      _controller.text = amount.toString();
    });
  }

  Future<void> convertCurrency() async {
    // const apiKey = 'b6a1a78d7ff966f8c9923532'; // Reemplaza con tu clave de API
    final url =
        'https://v6.exchangerate-api.com/v6/b6a1a78d7ff966f8c9923532/latest/$fromCurrency';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rate = data['conversion_rates'][toCurrency];
      setState(() {
        convertedAmount = amount * rate;
      });
    } else {
      // ignore: avoid_print
      print('Error en la solicitud HTTP: ${response.statusCode}');
    }
  }
  
  DropdownButton<String> buildCurrencyDropdown(String value, void Function(String?) onChanged) {
    final Map<String, dynamic> paises = {
      'Estados Unidos': {
        'emoji': '🇺🇸',
        'codigoMoneda': 'USD',
      },

      'México': {
        'emoji': '🇲🇽',
        'codigoMoneda': 'MXN',
      },
      'Unión Europea': {
        'emoji': '🇪🇺',
        'codigoMoneda': 'EUR',
      },
      'Japón': {
        'emoji': '🇯🇵',
        'codigoMoneda': 'JPY',
      },
      'Corea': {
        'emoji': '🇰🇷',
        'codigoMoneda': 'KRW',
      },
      'Chile': {
        'emoji': '🇨🇱',
        'codigoMoneda': 'CLP',
      },
      'Emiratos Árabes Unidos': {
        'emoji': '🇦🇪',
        'codigoMoneda': 'AED',
      },
      'China': {
        'emoji': '🇨🇳',
        'codigoMoneda': 'CNY',
      },
      'Rusia': {
        'emoji': '🇷🇺',
        'codigoMoneda': 'RUB',
      },
    };

  
    List<String> listaPaises = paises.entries
    .map((entry) => '${entry.value['emoji']} ${entry.value['codigoMoneda']}')
    .toList();

    return DropdownButton<String>(
      key: UniqueKey(),
      value: value,
      onChanged: onChanged,
      items: listaPaises
          .map<DropdownMenuItem<String>>((String currency) {
        final parts = currency.split(' ');
        final currencyCode = parts[1];
        return DropdownMenuItem<String>(
          value: currencyCode,
          child: Text(currency, style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
        );
      }).toList(),
      underline: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Conversor Monetario'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.width * 0.3),
            SizedBox(// Establecer el ancho al 60% de la pantalla
              width: MediaQuery.of(context).size.width * 0.6,
              child: Row(
                children: [
                  buildCurrencyDropdown(fromCurrency, (value) {
                    setState(() {
                      fromCurrency = value!;
                      convertCurrency();
                    });
                  }),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12.5, bottom: 12.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Cantidad',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20), 
                          isDense: true, 
                          hintStyle: const TextStyle(fontSize: 22), 
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white), 
                          ),
                        ),
                        keyboardType: TextInputType.number,

                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 22), 
                        onSubmitted: (value) {
                          setState(() {
                            amount = double.parse(value);
                          });
                          convertCurrency();
                        },
                      ),
                    )
                  ),
                  
                ],
              ),
            ),
            
            ElevatedButton(
              onPressed: cambiarValorPrimerDropdown,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 192, 236, 253), 
              ),
              child: const Icon(
                Icons.sync,
                color: Colors.black, 
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6, 
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12.5, bottom: 12.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: TextEditingController(text: convertedAmount.toStringAsFixed(2)),
                        readOnly: true, 
                        decoration: InputDecoration(
                          labelText: 'Resultado',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20), 
                          isDense: true, 
                          hintStyle: const TextStyle(fontSize: 22), 
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white), 
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center, 
                        style: const TextStyle(fontSize: 22), 
                      ),
                    )
                  ),
                  const SizedBox(width: 14), 
                  buildCurrencyDropdown(toCurrency, (value) {
                    setState(() {
                      toCurrency = value!;
                      convertCurrency();
                    });
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}