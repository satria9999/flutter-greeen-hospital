import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(BookApp());

class RumahSakit {
  final String idRumahSakit;
  final String namaRumahSakit;
  final String lokasi;

  RumahSakit({
    required this.idRumahSakit,
    required this.namaRumahSakit,
    required this.lokasi,
  });
}

class BookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RumahSakitView(),
    );
  }
}

class RumahSakitView extends StatefulWidget {
  @override
  _RumahSakitViewState createState() => _RumahSakitViewState();
}

class _RumahSakitViewState extends State<RumahSakitView> {
  List<RumahSakit> _rumahSakits = [];
  List<RumahSakit> _searchResult = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var url = Uri.parse('https://hospital.temanhorizon.com/rumahsakit.php');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _rumahSakits = List<RumahSakit>.from(data.map((rs) => RumahSakit(
              idRumahSakit: rs['id_rumahsakit'],
              namaRumahSakit: rs['nama_rumahsakit'],
              lokasi: rs['lokasi'],
            )));
      });
    } else {
      print('Failed to load data, status code: ${response.statusCode}');
    }
  }

  void _searchRumahSakit(String query) {
    _searchResult.clear();
    if (query.isNotEmpty) {
      setState(() {
        _searchResult = _rumahSakits
            .where((rumahSakit) => rumahSakit.namaRumahSakit
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
      return;
    } else {
      setState(() {
        _searchResult.clear();
      });
    }
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
          Column(
            children: [
              AppBar(
                title: Text('Rumah Sakit'),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: _searchRumahSakit,
                  decoration: InputDecoration(
                    labelText: 'Cari Rumah Sakit',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResult.length > 0
                      ? _searchResult.length
                      : _rumahSakits.length,
                  itemBuilder: (BuildContext context, int index) {
                    final rumahSakit = _searchResult.isNotEmpty
                        ? _searchResult[index]
                        : _rumahSakits[index];
                    return buildCard(rumahSakit);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCard(RumahSakit rumahSakit) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          rumahSakit.namaRumahSakit,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(rumahSakit.lokasi),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                  'assets/img/rumahsakit.png'), // Ganti dengan path gambar Anda
            ),
          ),
        ),
        onTap: () {
          // Aksi yang ingin diambil saat card ditekan, misalnya navigasi ke halaman detail
        },
      ),
    );
  }
}
