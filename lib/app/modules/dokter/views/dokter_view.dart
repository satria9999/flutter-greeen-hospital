import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:green_hospital/app/modules/dokter/views/detail_dokter.dart';

void main() => runApp(BookApp());

class Dokter {
  final String nomerDokter;
  final String namaDokter;
  final String spesialis;
  final String gender;

  Dokter({
    required this.nomerDokter,
    required this.namaDokter,
    required this.spesialis,
    required this.gender,
  });
}

class BookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DokterView(),
    );
  }
}

class DokterView extends StatefulWidget {
  @override
  _DokterViewState createState() => _DokterViewState();
}

class _DokterViewState extends State<DokterView> {
  List<Dokter> _dokters = [];
  List<Dokter> _searchResult = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var url = Uri.parse('https://hospital.temanhorizon.com/dokter.php');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _dokters = List<Dokter>.from(data.map((rs) => Dokter(
              nomerDokter: rs['nomer_dokter'] ?? '',
              namaDokter: rs['nama_dokter'] ?? '',
              spesialis: rs['spesialis'] ?? '',
              gender: rs['gender'] ?? '',
            )));
      });
    } else {
      print('Failed to load data, status code: ${response.statusCode}');
    }
  }

  void _searchDokter(String query) {
    _searchResult.clear();
    if (query.isNotEmpty) {
      setState(() {
        _searchResult = _dokters
            .where((dokter) =>
                dokter.nomerDokter
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                dokter.namaDokter.toLowerCase().contains(query.toLowerCase()) ||
                dokter.spesialis.toLowerCase().contains(query.toLowerCase()))
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
                image: AssetImage('assets/img/Background2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                title: Text('Data Dokter'),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: _searchDokter,
                  decoration: InputDecoration(
                    labelText: 'Cari Dokter',
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
                      : _dokters.length,
                  itemBuilder: (BuildContext context, int index) {
                    final dokter = _searchResult.isNotEmpty
                        ? _searchResult[index]
                        : _dokters[index];
                    return buildCard(dokter);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void navigateToDetailDokter(String nomerDokter) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DokterDetailPage(nomerDokter: nomerDokter)),
    );
  }

  Widget buildCard(Dokter dokter) {
    String foto;
    if (dokter.gender.toLowerCase() == 'perempuan') {
      foto = 'assets/img/perempuan.png';
    } else {
      foto = 'assets/img/pria.png';
    }

    return InkWell(
      onTap: () {
        navigateToDetailDokter(dokter.nomerDokter);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
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
            dokter.namaDokter,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nomer Dokter: ${dokter.nomerDokter}"),
              Text("Spesialis: ${dokter.spesialis}"),
            ],
          ),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(foto),
          ),
        ),
      ),
    );
  }
}
