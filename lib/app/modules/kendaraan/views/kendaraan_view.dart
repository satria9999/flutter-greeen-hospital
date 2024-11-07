import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() => runApp(BookApp());

class Kendaraan {
  final String sensor;

  Kendaraan({
    required this.sensor,
  });
}

class BookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor:
            Colors.transparent, // Latar belakang Scaffold transparan
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      home: KendaraanView(),
    );
  }
}

class KendaraanView extends StatefulWidget {
  @override
  _KendaraanViewState createState() => _KendaraanViewState();
}

class _KendaraanViewState extends State<KendaraanView> {
  late Future<Kendaraan> _kendaraan;
  Kendaraan _currentKendaraan =
      Kendaraan(sensor: ''); // Inisialisasi dengan nilai default
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _kendaraan = fetchData();
    // Inisialisasi timer untuk reload data setiap 3 detik
    _timer = Timer.periodic(
        Duration(seconds: 3), (Timer t) => reloadKendaraanData());
  }

  @override
  void dispose() {
    _timer.cancel(); // Hentikan timer saat widget di dispose
    super.dispose();
  }

  Future<Kendaraan> fetchData() async {
    var url = Uri.parse(
        'https://lora-project-a1063-default-rtdb.firebaseio.com/Skripsi.json');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Kendaraan(
        sensor: data['sensor'] ?? '', // Pastikan data sensor tidak null
      );
    } else {
      throw Exception(
          'Failed to load data, status code: ${response.statusCode}');
    }
  }

  Future<void> reloadKendaraanData() async {
    var newData = await fetchData();
    setState(() {
      _currentKendaraan = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/img/Background2.png'), // Path gambar latar belakang
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: Text('Data Kendaraan'),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                20,
                MediaQuery.of(context).padding.top + kToolbarHeight + 20,
                20,
                20),
            child: SingleChildScrollView(
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withOpacity(0.8), // Opacity for readability
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jumlah Kendaraan',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Motor: ${_currentKendaraan.sensor}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Mobil: 0',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
