import 'package:flutter/material.dart';
import 'package:green_hospital/app/modules/login/views/login_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class AdminView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        backgroundColor: Colors.white, // Warna latar belakang AppBar
        title: Text(
          "Admin Green Hospital",
          style: TextStyle(
            color: Colors.green, // Warna teks hijau
            fontWeight: FontWeight.bold, // Teks lebih tebal
            fontSize: 20, // Ukuran font 20
          ),
        ),

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: WebView(
        initialUrl: "https://hospital.temanhorizon.com/",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
