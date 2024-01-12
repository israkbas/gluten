import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class bildir extends StatefulWidget {
  @override
  _bildirState createState() => _bildirState();
}

class _bildirState extends State<bildir> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  Future<void> _addToFirebase() async {
    try {
      // Firestore bağlantısını başlat
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // "oneri" adında bir koleksiyon referansı oluştur
      CollectionReference oneriCollection = firestore.collection('oneri');

      // Koleksiyona yeni bir doküman ekleyin
      await oneriCollection.add({
        'field1': _controller1.text,
        'field2': _controller2.text,
        // Diğer alanları da ekleyebilirsiniz.
      });

      // Başarılı bir şekilde eklendiğinde kullanıcıya bir mesaj göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bildiriniz gönderilmiştir.'),
        ),
      );
    } catch (e) {
      // Hata durumunda kullanıcıya bir mesaj göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hata oluştu: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Firebase Örnek'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller1,
              decoration: InputDecoration(labelText: 'Field 1'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _controller2,
              decoration: InputDecoration(labelText: 'Field 2'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addToFirebase,
              child: Text('Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}
