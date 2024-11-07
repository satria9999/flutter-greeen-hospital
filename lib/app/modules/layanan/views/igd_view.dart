import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IGDView extends StatefulWidget {
  const IGDView({Key? key}) : super(key: key);

  @override
  _IGDViewState createState() => _IGDViewState();
}

class _IGDViewState extends State<IGDView> {
  late Future<List<Map<String, dynamic>>> _futureIGD;
  List<Map<String, dynamic>> _igdData = [];
  List<Map<String, dynamic>> _originalIGDData = [];

  @override
  void initState() {
    super.initState();
    _futureIGD = fetchIGD();
  }

  Future<List<Map<String, dynamic>>> fetchIGD() async {
    final response =
        await http.get(Uri.parse('https://hospital.temanhorizon.com/IGD.php'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      _originalIGDData = jsonData.cast<Map<String, dynamic>>().toList();
      _igdData = List.from(
          _originalIGDData); // Copy data asli ke dalam list yang dapat diubah
      return _igdData;
    } else {
      throw Exception('Failed to load IGD data');
    }
  }

  List<Map<String, dynamic>> _filterIGD(String query) {
    if (query.isEmpty) {
      return _originalIGDData; // Kembalikan ke data asli jika pencarian kosong
    } else {
      return _originalIGDData.where((data) {
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
                title: const Text('IGD & UGD'),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (query) {
                    setState(() {
                      _igdData = _filterIGD(query);
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
                  future: _futureIGD,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: _igdData.length,
                        itemBuilder: (context, index) {
                          final data = _igdData[index];
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
                                // Aksi ketika item IGD ditekan
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
    home: IGDView(),
  ));
}
