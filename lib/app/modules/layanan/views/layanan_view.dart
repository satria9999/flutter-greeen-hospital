import 'package:flutter/material.dart';
import '../views/igd_view.dart'; // Import file tampilan IGD
import './spesialis_choice.dart'; // Import file tampilan UGD

class LayananView extends StatelessWidget {
  const LayananView({Key? key}) : super(key: key);

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
                title: const Text('Layanan'),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      2, // Jumlah layanan yang ingin ditampilkan (IGD, UGD, Spesialis)
                  itemBuilder: (context, index) {
                    String layanan = '';
                    // Tentukan layanan sesuai dengan index
                    switch (index) {
                      case 0:
                        layanan = 'IGD/UGD';
                        break;
                      case 1:
                        layanan = 'Spesialis';
                        break;
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white.withOpacity(0.8),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            if (layanan == 'IGD/UGD') {
                              // Navigasi ke tampilan IGD
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IGDView()),
                              );
                            } else if (layanan == 'Spesialis') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SpesialisChoice()),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              layanan,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
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
    home: LayananView(),
  ));
}
