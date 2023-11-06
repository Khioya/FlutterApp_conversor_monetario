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
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  double amount = 1.0;
  String fromCurrency = 'USD';
  String toCurrency = 'EUR';
  double convertedAmount = 0.0;

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
  
  final flagEmojis = ['🇦🇪', '🇦🇫', '🇦🇱', '🇦🇲', '🇦🇳', '🇦🇴', '🇦🇷', '🇦🇺', '🇦🇼', '🇦🇿', '🇧🇦', '🇧🇧', '🇧🇩', '🇧🇬', '🇧🇭', '🇧🇮', '🇧🇲', '🇧🇳', '🇧🇴', '🇧🇷', '🇧🇸', '🇧🇹', '🇧🇼', '🇧🇾', '🇧🇿', '🇨🇦', '🇨🇩', '🇨🇭', '🇨🇱', '🇨🇳', '🇨🇴', '🇨🇷', '🇨🇺', '🇨🇻', '🇨🇿', '🇩🇯', '🇩🇰', '🇩🇴', '🇩🇿', '🇪🇬', '🇪🇷', '🇪🇹', '🇪🇺', '🇫🇯', '🇫🇰', '🇫🇴', '🇬🇧', '🇬🇪', '🇬🇬', '🇬🇭', '🇬🇮', '🇬🇲', '🇬🇳', '🇬🇹', '🇬🇾', '🇭🇰', '🇭🇳', '🇭🇷', '🇭🇹', '🇭🇺', '🇮🇩', '🇮🇱', '🇮🇲', '🇮🇳', '🇮🇶', '🇮🇷', '🇮🇸', '🇯🇪', '🇯🇲', '🇯🇴', '🇯🇵', '🇰🇪', '🇰🇬', '🇰🇭', '🇰🇮', '🇰🇲', '🇰🇷', '🇰🇼', '🇰🇾', '🇰🇿', '🇱🇦', '🇱🇧', '🇱🇰', '🇱🇷', '🇱🇸', '🇱🇾', '🇲🇦', '🇲🇩', '🇲🇬', '🇲🇰', '🇲🇲', '🇲🇳', '🇲🇴', '🇲🇷', '🇲🇺', '🇲🇻', '🇲🇼', '🇲🇽', '🇲🇾', '🇲🇿', '🇳🇦', '🇳🇬', '🇳🇮', '🇳🇴', '🇳🇵', '🇳🇿', '🇴🇲', '🇵🇦', '🇵🇪', '🇵🇬', '🇵🇭', '🇵🇰', '🇵🇱', '🇵🇾', '🇶🇦', '🇷🇴', '🇷🇸', '🇷🇺', '🇷🇼', '🇸🇦', '🇸🇧', '🇸🇨', '🇸🇩', '🇸🇪', '🇸🇬', '🇸🇭', '🇸🇱', '🇸🇴', '🇸🇷', '🇸🇸', '🇸🇹', '🇸🇾', '🇸🇿', '🇹🇭', '🇹🇯', '🇹🇲', '🇹🇳', '🇹🇴', '🇹🇷', '🇹🇹', '🇹🇻', '🇹🇼', '🇹🇿', '🇺🇦', '🇺🇬', '🇺🇸', '🇺🇾', '🇺🇿', '🇻🇪', '🇻🇳', '🇻🇺', '🇼🇸', '🇨🇫', '🇿🇦']; 
  final currencies = ['AED', 'AFN', 'ALL', 'AMD', 'ANG', 'AOA', 'ARS', 'AUD', 'AWG', 'AZN', 'BAM', 'BBD', 'BDT', 'BGN', 'BHD', 'BIF', 'BMD', 'BND', 'BOB', 'BRL', 'BSD', 'BTN', 'BWP', 'BYN', 'BZD', 'CAD', 'CDF', 'CHF', 'CLP', 'CNY', 'COP', 'CRC', 'CUP', 'CVE', 'CZK', 'DJF', 'DKK', 'DOP', 'DZD', 'EGP', 'ERN', 'ETB', 'EUR', 'FJD', 'FKP', 'FOK', 'GBP', 'GEL', 'GGP', 'GHS', 'GIP', 'GMD', 'GNF', 'GTQ', 'GYD', 'HKD', 'HNL', 'HRK', 'HTG', 'HUF', 'IDR', 'ILS', 'IMP', 'INR', 'IQD', 'IRR', 'ISK', 'JEP', 'JMD', 'JOD', 'JPY', 'KES', 'KGS', 'KHR', 'KID', 'KMF', 'KRW', 'KWD', 'KYD', 'KZT', 'LAK', 'LBP', 'LKR', 'LRD', 'LSL', 'LYD', 'MAD', 'MDL', 'MGA', 'MKD', 'MMK', 'MNT', 'MOP', 'MRU', 'MUR', 'MVR', 'MWK', 'MXN', 'MYR', 'MZN', 'NAD', 'NGN', 'NIO', 'NOK', 'NPR', 'NZD', 'OMR', 'PAB', 'PEN', 'PGK', 'PHP', 'PKR', 'PLN', 'PYG', 'QAR', 'RON', 'RSD', 'RUB', 'RWF', 'SAR', 'SBD', 'SCR', 'SDG', 'SEK', 'SGD', 'SHP', 'SLE', 'SOS', 'SRD', 'SSP', 'STN', 'SYP', 'SZL', 'THB', 'TJS', 'TMT', 'TND', 'TOP', 'TRY', 'TTD', 'TVD', 'TWD', 'TZS', 'UAH', 'UGX', 'USD', 'UYU', 'UZS', 'VES', 'VND', 'VUV', 'WST', 'XAF', 'ZAR'];
  final countries = ['Dirham de los Emiratos Árabes Unidos', 'Afgani afgano', 'Lek albanés', 'Dram armenio', 'Florín antillano neerlandés', 'Kwanza angoleño', 'Peso argentino', 'Dólar australiano', 'Florín arubeño', 'Manat azerbaiyano', 'Marco de Bosnia y Herzegovina', 'Dólar de Barbados', 'Taka bangladesí', 'Lev búlgaro', 'Dinar bahreiní', 'Franco burundés', 'Dólar bermudeño', 'Dólar de Brunéi', 'Boliviano boliviano', 'Real brasileño', 'Dólar bahameño', 'Ngultrum butanés', 'Pula de Botsuana', 'Rublo bielorruso', 'Dólar de Belice', 'Dólar canadiense', 'Franco congoleño', 'Franco suizo', 'Peso chileno', 'Renminbi chino', 'Peso colombiano', 'Colón costarricense', 'Peso cubano', 'Escudo caboverdiano', 'Corona checa', 'Franco yibutiano', 'Corona danesa', 'Peso dominicano', 'Dinar argelino', 'Libra egipcia', 'Nakfa eritreo', 'Birr etíope', 'Euro (Unión Europea)', 'Dólar fiyiano', 'Libra de las Islas Malvinas', 'Króna de las Islas Feroe', 'Libra esterlina (Reino Unido)', 'Lari georgiano', 'Libra de Guernsey', 'Cedi ghanés', 'Libra de Gibraltar', 'Dalasi gambiano', 'Franco guineano', 'Quetzal guatemalteco', 'Dólar guyanés', 'Dólar de Hong Kong', 'Lempira hondureño', 'Kuna croata', 'Gourde haitiano', 'Forint húngaro', 'Rupia indonesia', 'Nuevo shéquel israelí', 'Libra de la Isla de Man', 'Rupia india', 'Dinar iraquí', 'Rial iraní', 'Króna islandesa', 'Libra de Jersey', 'Dólar jamaicano', 'Dinar jordano', 'Yen japonés', 'Chelín keniano', 'Som kirguís', 'Riel camboyano', 'Dólar de Kiribati', 'Franco comorense', 'Won surcoreano', 'Dinar kuwaití', 'Dólar de las Islas Caimán', 'Tenge kazajo', 'Kip laosiano', 'Libra libanesa', 'Rupia de Sri Lanka', 'Dólar liberiano', 'Loti de Lesoto', 'Dinar libio', 'Dirham marroquí', 'Leu moldavo', 'Ariary malgache', 'Denar macedonio', 'Kyat birmano', 'Tögrög mongol', 'Pataca de Macao', 'Ouguiya mauritana', 'Rupia mauriciana', 'Rufiyaa de Maldivas', 'Kwacha de Malaui', 'Peso mexicano', 'Ringgit malasio', 'Metical mozambiqueño', 'Dólar namibio', 'Naira nigeriana', 'Córdoba nicaragüense', 'Corona noruega', 'Rupia nepalesa', 'Dólar neozelandés', 'Rial omaní', 'Balboa panameño', 'Sol peruano', 'Kina de Papúa Nueva Guinea', 'Peso filipino', 'Rupia paquistaní', 'Złoty polaco', 'Guaraní paraguayo', 'Riyal qatarí', 'Leu rumano', 'Dinar serbio', 'Rublo ruso', 'Franco ruandés', 'Riyal saudí', 'Dólar de las Islas Salomón', 'Rupia de Seychelles', 'Libra sudanesa', 'Corona sueca', 'Dólar de Singapur', 'Libra de Santa Helena', 'Leona de Sierra Leona', 'Chelín somalí', 'Dólar surinamés', 'Libra sursudanesa', 'Dobra de Santo Tomé y Príncipe', 'Libra siria', 'Lilangeni de Suazilandia', 'Baht tailandés', 'Somoni tayiko', 'Manat turcomano', 'Dinar tunecino', 'Paʻanga tongano', 'Lira turca', 'Dólar de Trinidad y Tobago', 'Dólar de Tuvalu', 'Nuevo dólar taiwanés', 'Chelín tanzano', 'Grivna ucraniana', 'Chelín ugandés', 'Dólar estadounidense', 'Peso uruguayo', 'Soʻm uzbeko', 'Bolívar soberano venezolano', 'Đồng vietnamita', 'Vatu vanuatuense', 'Tālā samoano', 'Franco CFA de África Central', 'Franco CFA de África Occidental','Rand sudafricano'];

  List<String> combinedCurrencies = List.generate(currencies.length, (index) => '${flagEmojis[index]} ${currencies[index]} / ${countries[index]}');
  
  return DropdownButton<String>(
    value: value,
    onChanged: onChanged,
    items: combinedCurrencies
        .map<DropdownMenuItem<String>>((String currency) {
      final parts = currency.split(' / ');
      final currencyCode = parts[0].split(' ')[1]; // Obtén la abreviatura de la moneda
      return DropdownMenuItem<String>(
        value: currencyCode,
        child: Text(currency),
      );
    }).toList(),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Cantidad a convertir'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  amount = double.parse(value);
                });
              },
            ),
            buildCurrencyDropdown(fromCurrency, (value) {
              setState(() {
                fromCurrency = value!;
              });
            }),
            // ignore: prefer_const_constructors
            Text('a'),
            buildCurrencyDropdown(toCurrency, (value) {
              setState(() {
                toCurrency = value!;
              });
            }),
            ElevatedButton(
              onPressed: convertCurrency,
              child: const Text('Convertir'),
            ),
            Text('Resultado: $convertedAmount $toCurrency'),
          ],
        ),
      ),
    );
  }
  

}