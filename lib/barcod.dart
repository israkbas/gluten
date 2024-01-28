import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Barcode extends StatelessWidget {
  Future<void> _openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _showDataDialog(
      BuildContext context, DocumentSnapshot ilac) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 400,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        //child: IconSwitcher(),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "GlutenCheck",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Text('İlaç Adı: ${ilac['Ilaç Adı'].toString()}'),
                  SizedBox(height: 20),
                  Text('Reçete Türü: ${ilac['Reçete Turu'].toString()}'),
                  SizedBox(height: 20),
                  Text('ATC Adı: ${ilac['ATC Adı'].toString()}'),
                  SizedBox(height: 20),
                  Text('ATC Kodu: ${ilac['ATC Kodu'].toString()}'),
                  SizedBox(height: 20),
                  Text('Barkod: ${ilac['Barkod'].toString()}'),
                  SizedBox(height: 20),
                  Text('Firma Adı: ${ilac['Firma Adı'].toString()}'),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDataNotFoundDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Veri Bulunamadı'),
          content: Text('Barkod ile eşleşen ilaç verisi bulunamadı.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Kapat'),
            ),
          ],
        );
      },
    );
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
                        // Firebase'den ilaç bilgilerini çekme
                        var ilacSnap = await FirebaseFirestore.instance
                            .collection('ilac')
                            .doc(result.rawContent)
                            .get();

                        if (ilacSnap.exists) {
                          // Veri varsa dialog gösterme
                          _showDataDialog(context, ilacSnap);
                        } else {
                          // Veri yoksa uyarı gösterme
                          _showDataNotFoundDialog(context);
                        }
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
