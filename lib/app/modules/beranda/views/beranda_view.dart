import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:green_hospital/app/modules/kendaraan/views/kendaraan_view.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:green_hospital/app/modules/ambulance/views/ambulance_view.dart';
import 'package:green_hospital/app/modules/dokter/views/dokter_view.dart';
import 'package:green_hospital/app/modules/layanan/views/layanan_view.dart';
import 'package:green_hospital/app/modules/rumah_sakit/views/rumah_sakit_view.dart';
import 'package:green_hospital/app/modules/login/views/login_view.dart';

class BerandaView extends StatefulWidget {
  @override
  _BerandaViewState createState() => _BerandaViewState();
}

class _BerandaViewState extends State<BerandaView> {
  int _selectedNavbar = 0;
  List<String> _sliderImages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSliderImages();
  }

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  Future<void> fetchSliderImages() async {
    try {
      final response = await http
          .get(Uri.parse('https://hospital.temanhorizon.com/sliderimage.php'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          _sliderImages = List<String>.from(
              jsonData); // Menggunakan langsung data yang diterima dari JSON
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load slider images');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void logout() async {
    // Tambahkan logika logout di sini
    // Misalnya, untuk mengarahkan ke halaman login:
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      GridView.count(
        padding: EdgeInsets.only(top: 60),
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.grey[400]!,
                width: 1,
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RumahSakitView()));
              },
              style: ElevatedButton.styleFrom(
                      // Hapus properti primary, onPrimary, dan onSurface dari styleFrom
                      )
                  .merge(
                // Merge dengan gaya tambahan
                ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  // Anda juga dapat menentukan properti lain seperti padding, border, dll. di sini
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/img/hospital.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text("Rumah Sakit", style: TextStyle(fontSize: 17.0)),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.grey[400]!,
                width: 1,
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DokterView()));
              },
              style: ElevatedButton.styleFrom(
                      // Hapus properti primary, onPrimary, dan onSurface dari styleFrom
                      )
                  .merge(
                // Merge dengan gaya tambahan
                ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  // Anda juga dapat menentukan properti lain seperti padding, border, dll. di sini
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/img/nakes.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text("Nakes", style: TextStyle(fontSize: 17.0)),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.grey[400]!,
                width: 1,
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LayananView()));
              },
              style: ElevatedButton.styleFrom(
                      // Hapus properti primary, onPrimary, dan onSurface dari styleFrom
                      )
                  .merge(
                // Merge dengan gaya tambahan
                ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  // Anda juga dapat menentukan properti lain seperti padding, border, dll. di sini
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/img/layanan.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text("Layanan", style: TextStyle(fontSize: 17.0)),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.grey[400]!,
                width: 1,
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AmbulancePage()));
              },
              style: ElevatedButton.styleFrom(
                      // Hapus properti primary, onPrimary, dan onSurface dari styleFrom
                      )
                  .merge(
                // Merge dengan gaya tambahan
                ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  // Anda juga dapat menentukan properti lain seperti padding, border, dll. di sini
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/img/ambulance.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text("Ambulance", style: TextStyle(fontSize: 17.0)),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.grey[400]!,
                width: 1,
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => KendaraanView()));
              },
              style: ElevatedButton.styleFrom(
                      // Hapus properti primary, onPrimary, dan onSurface dari styleFrom
                      )
                  .merge(
                // Merge dengan gaya tambahan
                ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  // Anda juga dapat menentukan properti lain seperti padding, border, dll. di sini
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/img/ambulance.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text("Kendaraan", style: TextStyle(fontSize: 17.0)),
                ],
              ),
            ),
          ),
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Hi, Selamat Datang',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              logout(); // Panggil fungsi logout ketika tombol logout ditekan
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CarouselSlider(
                  items: _sliderImages.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://hospital.temanhorizon.com/$imageUrl', // Menambahkan host ke URL gambar
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      // Do something when page is changed
                    },
                  ),
                ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: widgets[_selectedNavbar],
            ),
          ),
        ],
      ),
    );
  }
}
