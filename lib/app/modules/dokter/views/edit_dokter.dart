import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EditDokterPage extends StatelessWidget {
  final String nomerDokter;
  final String url;

  EditDokterPage({required this.nomerDokter}) : url = 'https://hospital.temanhorizon.com/Dokter/edit_data/$nomerDokter';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Dokter'),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
