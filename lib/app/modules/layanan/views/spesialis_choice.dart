import 'package:flutter/material.dart';
import '../views/spesialis/jantung.dart'; // Import file tampilan Jantung
import 'spesialis_view.dart'; // Import file tampilan Spesialis

class SpesialisChoice extends StatelessWidget {
  const SpesialisChoice({Key? key}) : super(key: key);

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
                title: const Text('Spesialis'),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      3, // Jumlah layanan yang ingin ditampilkan (Jantung, Paru, Kulit)
                  itemBuilder: (context, index) {
                    String layanan = '';
                    // Tentukan layanan sesuai dengan index
                    switch (index) {
                      case 0:
                        layanan = 'Jantung';
                        break;
                      case 1:
                        layanan = 'Paru';
                        break;
                      case 2:
                        layanan = 'Kulit';
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
                            if (layanan == 'Jantung') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JantungView()),
                              );
                            } else if (layanan == 'Paru') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SpesialisView()),
                              );
                            } else if (layanan == 'Kulit') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SpesialisView()),
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
    home: SpesialisChoice(),
  ));
}
