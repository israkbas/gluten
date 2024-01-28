import 'package:flutter/material.dart';
import 'package:gluten_check/LoginPage/login.dart';
import 'package:gluten_check/fav.dart';
import 'package:gluten_check/home.dart';
import 'package:gluten_check/urunBildir.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _getPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return Home();
      case 1:
        return Fav();
      // Veriler düzenlenerek favoriler sayfası yapılabilir.
      // Veri boyutu çok fazla olduğundan düzenlenemedi. Daha sonra güncellemede bütün verilere false değeri verilecek
      // daha sonra icona tıklandığında true dönecek ve favoriler ekranına eklenecek.

      default:
        return Container();
    }
  }

  Future<void> _openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GlutenCheck',
          style: TextStyle(
            color: Colors.brown.shade400,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            letterSpacing: 2,
            wordSpacing: 3.0,
          ),
        ),
      ),
      body: Center(
        child: _getPage(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: changePage,
        type: BottomNavigationBarType.fixed,
        iconSize: 35,
        fixedColor: Color.fromARGB(255, 223, 209, 189),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 100,
            ),
            ListTile(
              title: Text('Ürün Bildir'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Oneri()),
                );
              },
            ),
            ListTile(
              title: Text('Çıkış Yap'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
