import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Oneri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      appBar: (AppBar()),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Ilac()),
                );
              },
              child: Text('İlaç Bildirimi'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Gida()),
                );
              },
              child: Text('Gıda Bildirimi'),
            ),
          ],
        ),
      ),
    );
  }
}

class Gida extends StatefulWidget {
  const Gida({super.key});

  @override
  State<Gida> createState() => _GidaState();
}

class _GidaState extends State<Gida> {
  TextEditingController _gidaController = TextEditingController();
  TextEditingController _aaltkategoriController = TextEditingController();
  TextEditingController _altkategoriController = TextEditingController();
  TextEditingController _kategoriController = TextEditingController();
  TextEditingController _markaController = TextEditingController();
  TextEditingController _uyariekController = TextEditingController();
  TextEditingController _uygunlukdurumuController = TextEditingController();
  TextEditingController _uretimController = TextEditingController();
  TextEditingController _aciklamaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gıda Bildirimi'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _gidaController,
                decoration: InputDecoration(labelText: 'Ürün'),
              ),
              TextField(
                controller: _aaltkategoriController,
                decoration: InputDecoration(labelText: 'Daha Alt Kategori'),
              ),
              TextField(
                controller: _altkategoriController,
                decoration: InputDecoration(labelText: 'Alt Kategori'),
              ),
              TextField(
                controller: _kategoriController,
                decoration: InputDecoration(labelText: 'Kategori'),
              ),
              TextField(
                controller: _markaController,
                decoration: InputDecoration(labelText: 'Marka'),
              ),
              TextField(
                controller: _uyariekController,
                decoration: InputDecoration(labelText: 'Uyarı - Ek Bilgi'),
              ),
              TextField(
                controller: _uygunlukdurumuController,
                decoration: InputDecoration(labelText: 'Uygunluk Durumu'),
              ),
              TextField(
                controller: _uretimController,
                decoration: InputDecoration(labelText: 'Üretim Yeri'),
              ),
              TextField(
                controller: _aciklamaController,
                decoration: InputDecoration(labelText: 'Açıklama'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TextField içindeki değerleri alma
                  String gida = _gidaController.text;
                  String aaltk = _aaltkategoriController.text;
                  String altk = _altkategoriController.text;
                  String kategori = _kategoriController.text;
                  String marka = _markaController.text;
                  String uyari = _uyariekController.text;
                  String uygunluk = _uygunlukdurumuController.text;
                  String uretim = _uretimController.text;
                  String aciklama = _aciklamaController.text;

                  // Firebase koleksiyonuna veri ekleme
                  FirebaseFirestore.instance.collection('Gıda Öneri').add({
                    'Gıda Adı': gida,
                    'Daha Alt Kategori': aaltk,
                    'Alt Kategori': altk,
                    'Kategori': kategori,
                    'Marka': marka,
                    'Uyarı- Ek Bilgi': uyari,
                    'Uygunluk durumu': uygunluk,
                    'Üretim Yeri': uretim,
                    'Açıklama': aciklama,
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Bildiriniz gönderildi'),
                    ));
                    print('Veri başarıyla eklendi!');
                    // Veri başarıyla eklendiyse
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Bildiriniz gönderildi'),
                    ));
                    print('Veri başarıyla eklendi!');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Oneri()));
                    // Veri başarıyla eklendiyse
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Gönderilemedi! Tekrar Deneyiniz.'),
                    ));
                    // Hata durumunda
                    print('Hata oluştu: $error');
                  });
                },
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Ilac extends StatefulWidget {
  @override
  State<Ilac> createState() => _IlacState();
}

class _IlacState extends State<Ilac> {
  TextEditingController _atcadiController = TextEditingController();
  TextEditingController _atckoduController = TextEditingController();
  TextEditingController _barkodController = TextEditingController();
  TextEditingController _firmaadiController = TextEditingController();
  TextEditingController _ilacadiController = TextEditingController();
  TextEditingController _receteturuController = TextEditingController();
  TextEditingController _uygunlukdurumuController = TextEditingController();
  TextEditingController _aciklamaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        title: Text('İlaç Bildirimi'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _atcadiController,
                decoration: InputDecoration(labelText: 'ATC Adı'),
              ),
              TextField(
                controller: _atckoduController,
                decoration: InputDecoration(labelText: 'ATC Kodu'),
              ),
              TextField(
                controller: _barkodController,
                decoration: InputDecoration(labelText: 'Barkod'),
              ),
              TextField(
                controller: _firmaadiController,
                decoration: InputDecoration(labelText: 'Firma Adı'),
              ),
              TextField(
                controller: _ilacadiController,
                decoration: InputDecoration(labelText: 'İlaç Adı'),
              ),
              TextField(
                controller: _receteturuController,
                decoration: InputDecoration(labelText: 'Reçete Türü'),
              ),
              TextField(
                controller: _uygunlukdurumuController,
                decoration: InputDecoration(labelText: 'Uygunluk Durumu'),
              ),
              TextField(
                controller: _aciklamaController,
                decoration: InputDecoration(labelText: 'Açıklama'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TextField içindeki değerleri alma
                  String atcadi = _atcadiController.text;
                  String aciklama = _aciklamaController.text;
                  String atckodu = _atckoduController.text;
                  String barkod = _barkodController.text;
                  String firmaadi = _firmaadiController.text;
                  String receteturu = _receteturuController.text;
                  String uygunlukd = _uygunlukdurumuController.text;
                  String ilacadi = _ilacadiController.text;

                  // Firebase koleksiyonuna veri ekleme
                  FirebaseFirestore.instance.collection('İlaç Öneri').add({
                    'ATC Adı': atcadi,
                    'ATC Kodu': atckodu,
                    'Barkod': barkod,
                    'Firma Adı': firmaadi,
                    'İlaç Adı': ilacadi,
                    'Reçete Türü': receteturu,
                    'Uygunluk durumu': uygunlukd,
                    'Açıklama': aciklama,
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Bildiriniz gönderildi'),
                    ));
                    print('Veri başarıyla eklendi!');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Oneri()));
                    // Veri başarıyla eklendiyse
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Gönderilemedi! Tekrar Deneyiniz.'),
                    ));
                    // Hata durumunda
                    print('Hata oluştu: $error');
                  });
                },
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
