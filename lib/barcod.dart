import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Barcode extends StatelessWidget {
  Future<void> _openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GlutenCheck',
      home: Scaffold(
        body: Center(
          child: Container(
            width: double.infinity,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      var result = await BarcodeScanner.scan();
                      if (result.type == ResultType.Barcode) {
                        await _openURL(result.rawContent);
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text('Scan Gluten'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
