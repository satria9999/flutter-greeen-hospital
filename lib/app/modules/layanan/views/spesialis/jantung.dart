import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JantungView extends StatefulWidget {
  const JantungView({Key? key}) : super(key: key);

  @override
  _JantungViewState createState() => _JantungViewState();
}

class _JantungViewState extends State<JantungView> {
  late Future<List<Map<String, dynamic>>> _futureJantung;
  List<Map<String, dynamic>> _jantungData = [];
  List<Map<String, dynamic>> _originalJantungData = [];

  @override
  void initState() {
    super.initState();
    _futureJantung = fetchJantung();
  }

  Future<List<Map<String, dynamic>>> fetchJantung() async {
    final response = await http
        .get(Uri.parse('https://hospital.temanhorizon.com/Jantung.php'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      _originalJantungData = jsonData.cast<Map<String, dynamic>>().toList();
      _jantungData = List.from(
          _originalJantungData); // Copy data asli ke dalam list yang dapat diubah
      return _jantungData;
    } else {
      throw Exception('Failed to load Jantung data');
    }
  }

  List<Map<String, dynamic>> _filterJantung(String query) {
    if (query.isEmpty) {
      return _originalJantungData; // Kembalikan ke data asli jika pencarian kosong
    } else {
      return _originalJantungData.where((data) {
        final String namaRumahSakit = data['nama_rumahsakit'].toLowerCase();
        final String lokasi = data['lokasi'].toLowerCase();
        final String searchText = query.toLowerCase();
        return namaRumahSakit.contains(searchText) ||
            lokasi.contains(searchText);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gambar latar belakang
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/img/Background2.png'), // Path gambar latar belakang
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                title: const Text('Jantung'),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (query) {
                    setState(() {
                      _jantungData = _filterJantung(query);
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Search by Hospital Name or Location',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _futureJantung,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: _jantungData.length,
                        itemBuilder: (context, index) {
                          final data = _jantungData[index];
                          return Card(
                            elevation: 3,
                            margin: EdgeInsets.all(8),
                            color: Colors.white.withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                'Nama Layanan: ${data['nama_layanan']}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Rumah Sakit: ${data['nama_rumahsakit']}'),
                                  Text('Lokasi: ${data['lokasi']}'),
                                ],
                              ),
                              onTap: () {
                                // Aksi ketika item Jantung ditekan
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: JantungView(),
  ));
}
