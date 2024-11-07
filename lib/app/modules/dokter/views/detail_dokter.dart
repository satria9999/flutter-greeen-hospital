import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:green_hospital/app/modules/dokter/views/edit_dokter.dart';

class Dokter {
  final String nomerDokter;
  final String namaDokter;
  final String spesialis;
  final String gender;
  final String namaRumahSakit;
  final String lokasi;
  final String waktuMulai;
  final String waktuSelesai;

  Dokter({
    required this.nomerDokter,
    required this.namaDokter,
    required this.spesialis,
    required this.gender,
    required this.namaRumahSakit,
    required this.lokasi,
    required this.waktuMulai,
    required this.waktuSelesai,
  });

  factory Dokter.fromJson(Map<String, dynamic> json) {
    return Dokter(
      nomerDokter: json['nomer_dokter'] ?? '',
      namaDokter: json['nama_dokter'] ?? '',
      spesialis: json['spesialis'] ?? '',
      gender: json['gender'] ?? '',
      namaRumahSakit: json['nama_rumahsakit'] ?? '',
      lokasi: json['lokasi'] ?? '',
      waktuMulai: json['waktu_mulai'] ?? '',
      waktuSelesai: json['waktu_selesai'] ?? '',
    );
  }
}

class DokterDetailPage extends StatelessWidget {
  final String nomerDokter;

  DokterDetailPage({required this.nomerDokter});

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
                title: Text('Detail Dokter'),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditDokterPage(nomerDokter: nomerDokter),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: fetchData(nomerDokter),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return buildDetail(snapshot.data as Dokter);
                    } else {
                      return Center(
                          child: Text('Tidak ada data yang tersedia'));
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

  Future<Dokter> fetchData(String nomerDokter) async {
    var url = Uri.parse(
        'https://hospital.temanhorizon.com/detail_dokter.php?nomer_dokter=$nomerDokter');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data != null && data.isNotEmpty) {
        return Dokter.fromJson(data[0]);
      } else {
        throw Exception('Data kosong');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Widget buildDetail(Dokter dokter) {
    String foto;
    if (dokter.gender.toLowerCase() == 'perempuan') {
      foto = 'assets/img/perempuan.png'; // Path gambar perempuan
    } else {
      foto = 'assets/img/pria.png'; // Path gambar laki-laki
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(foto),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dokter.namaDokter,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          dokter.spesialis,
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            dokter.gender,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.local_hospital),
              title: Text('Nama Rumah Sakit'),
              subtitle: Text(dokter.namaRumahSakit),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Lokasi'),
              subtitle: Text(dokter.lokasi),
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('Waktu Praktek'),
              subtitle: Text('${dokter.waktuMulai} - ${dokter.waktuSelesai}'),
            ),
          ],
        ),
      ),
    );
  }
}
