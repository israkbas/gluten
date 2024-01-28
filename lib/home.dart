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
      appBar: AppBar(),
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
      appBar: AppBar(),
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
              onChanged: (value) {
                setState(() {
                  searchController;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('ilac')
                    .where('Ilaç Adı',
                        isGreaterThanOrEqualTo: searchController.text)
                    .snapshots(),
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

                      // İlac verilerini kullanarak ListTile oluşturma
                      return ListTile(
                        title: Text(ilac['Ilaç Adı'].toString()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Reçete Türü: ${ilac['Reçete Turu'].toString()}'),
                            Text('Barkod: ${ilac['Barkod'].toString()}'),
                            Text('Firma Adı: ${ilac['Firma Adı'].toString()}'),
                            Text(
                                'Uygunluk Durumu: ${ilac['Uygunluk Durumu '].toString()}'),
                          ],
                        ),
                        onTap: () {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            child: IconSwitcher(),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "GlutenCheck",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Text(
                                          'İlaç Adı: ${ilac['Ilaç Adı'].toString()}'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'Reçete Türü: ${ilac['Reçete Turu'].toString()}'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'ATC Adı: ${ilac['ATC Adı'].toString()}'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'ATC Kodu: ${ilac['ATC Kodu'].toString()}'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'Barkod: ${ilac['Barkod'].toString()}'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'Firma Adı: ${ilac['Firma Adı'].toString()}'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'Uygunluk Durumu: ${ilac['Uygunluk Durumu '].toString()}'),
                                    ],
                                  ),
                                )),
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
                        },
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

class IconSwitcher extends StatefulWidget {
  @override
  _IconSwitcherState createState() => _IconSwitcherState();
}

class _IconSwitcherState extends State<IconSwitcher> {
  bool isSecondIcon = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSecondIcon = !isSecondIcon;
        });
      },
      child: isSecondIcon ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
    );
  }
}

class GidaPage extends StatefulWidget {
  @override
  State<GidaPage> createState() => _GidaPageState();
}

class _GidaPageState extends State<GidaPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              onChanged: (value) {
                setState(() {
                  searchController;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('gida')
                    .where('MARKA',
                        isGreaterThanOrEqualTo: searchController.text)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  var gidaListesi = snapshot.data?.docs;
                  return ListView.builder(
                    itemCount: gidaListesi!.length,
                    itemBuilder: (context, index) {
                      var gida =
                          gidaListesi[index].data() as Map<String, dynamic>;

                      // Gida verilerini kullanarak ListTile oluşturma
                      return ListTile(
                        title: Text('${gida['ÜRÜN']} - ${gida['MARKA']}'),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${gida['ALT KATEGORİ']}'),
                              Text(
                                '${gida['KATEGORİ'].toString()}',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              Text(
                                  'Alt Kategori: ${gida['AALT KATEGORİ'].toString()}'),
                              Text('Üretim Yeri: ${gida['ÜRETİM'].toString()}'),
                              Text(
                                  'Uygunluk Durumu: ${gida['UYGUNLUK DURUMU'].toString()}'),
                              Text(
                                  'Ek bilgi- Uyarı: ${gida['UYARI- EK BİLGİ'].toString()}'),
                            ]),
                        onTap: () {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            child: IconSwitcher(),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "GlutenCheck",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Text(
                                          'Marka: ${gida['MARKA'].toString()}'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'Kategori: ${gida['KATEGORİ'].toString()}'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'Alt Kategori: ${gida['ALT KATEGORİ'].toString()}'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'Daha Alt Kategori: ${gida['AALT KATEGORİ'].toString()}'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'Üretim Yeri: ${gida['ÜRETİM'].toString()}'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'Uygunluk Durumu: ${gida['UYGUNLUK DURUMU'].toString()}'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'Ek bilgi- Uyarı: ${gida['UYARI- EK BİLGİ'].toString()}'),
                                    ],
                                  ),
                                )),
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
                        },
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
