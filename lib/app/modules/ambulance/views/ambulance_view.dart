import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Ambulance {
  final int id;
  final String namaRumahSakit;
  final String nomorTelepon;
  final bool hotline;

  Ambulance({
    required this.id,
    required this.namaRumahSakit,
    required this.nomorTelepon,
    required this.hotline,
  });

  factory Ambulance.fromJson(Map<String, dynamic> json) {
    return Ambulance(
      id: int.parse(json['id_ambulance']),
      namaRumahSakit: json['nama_rumahsakit'],
      nomorTelepon: json['nomor_telepon'],
      hotline:
          json['hotline'] == 'true', // Memastikan bahwa hotline adalah boolean
    );
  }
}

class AmbulancePage extends StatefulWidget {
  @override
  _AmbulancePageState createState() => _AmbulancePageState();
}

class _AmbulancePageState extends State<AmbulancePage> {
  late Future<List<Ambulance>> _futureAmbulance;

  @override
  void initState() {
    super.initState();
    _futureAmbulance = fetchAmbulance();
  }

  Future<List<Ambulance>> fetchAmbulance() async {
    final response = await http
        .get(Uri.parse('https://hospital.temanhorizon.com/ambulance.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Ambulance.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load ambulance');
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
                title: Text('Ambulance'),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: FutureBuilder<List<Ambulance>>(
                  future: _futureAmbulance,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final List<Ambulance> ambulances = snapshot.data!;
                      return ListView.builder(
                        itemCount: ambulances.length,
                        itemBuilder: (context, index) {
                          final ambulance = ambulances[index];
                          return Card(
                            elevation: 3,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/img/ambulance.png'),
                                radius: 25,
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text(ambulance.namaRumahSakit),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Telepon: ${ambulance.nomorTelepon}'),
                                  Text(
                                      'Hotline: ${ambulance.hotline ? 'Tersedia' : 'Tidak Tersedia'}'),
                                ],
                              ),
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
    home: AmbulancePage(),
  ));
}
