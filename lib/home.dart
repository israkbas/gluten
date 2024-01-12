import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IlacPage()),
                );
              },
              child: Text('İlaçlar'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GidaPage()),
                );
              },
              child: Text('Gıdalar'),
            ),
          ],
        ),
      ),
    );
  }
}

class IlacPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlaçlar ve Gıdalar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  var result = await BarcodeScanner.scan();
                  if (result.type == ResultType.Barcode) {}
                } catch (e) {
                  print(e.toString());
                }
              },
              child: Text('Barkod ile Bul'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Ara()),
                );
              },
              child: Text('Ara'),
            ),
          ],
        ),
      ),
    );
  }
}

class Ara extends StatefulWidget {
  @override
  State<Ara> createState() => _AraState();
}

class _AraState extends State<Ara> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ara'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Arama yap...',
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('ilac').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  var ilacListesi = snapshot.data?.docs;
                  return ListView.builder(
                    itemCount: ilacListesi!.length,
                    itemBuilder: (context, index) {
                      var ilac =
                          ilacListesi[index].data() as Map<String, dynamic>;

                      // İlac verilerini kullanarak ListTile oluşturun
                      return ListTile(
                        title: Text(ilac['Ilaç Adı'].toString()),
                        subtitle: Text(ilac['Reçete Turu'].toString()),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GidaPage extends StatefulWidget {
  @override
  State<GidaPage> createState() => _GidaPageState();
}

class _GidaPageState extends State<GidaPage> {
  // TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ara'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              //  controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Arama yap...',
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('gida').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  var gidaListesi =
                      snapshot.data?.docs; // Change variable name here
                  return ListView.builder(
                    itemCount: gidaListesi!.length,
                    itemBuilder: (context, index) {
                      var gida =
                          gidaListesi[index].data() as Map<String, dynamic>;

                      // Gida verilerini kullanarak ListTile oluşturun
                      return ListTile(
                        title: Text(gida['KATEGORİ'].toString()),
                        subtitle: Text(gida['MARKA'].toString()),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
