import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  late List<DocumentSnapshot> originalList;
  List<DocumentSnapshot> filteredList = [];

  @override
  void initState() {
    super.initState();
    // Initialize the originalList here
    originalList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arama Sayfası'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                filterList(value);
              },
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

                  originalList = snapshot.data?.docs ?? [];
                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      var ilac =
                          filteredList[index].data() as Map<String, dynamic>;

                      return GestureDetector(
                        onTap: () {
                          // Show additional information on item click
                          showAlertDialog(context, ilac);
                        },
                        child: ListTile(
                          title: Text(ilac['Ilaç Adı'].toString()),
                          subtitle: Text(ilac['Reçete Turu'].toString()),
                        ),
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

  void filterList(String query) {
    query = query.toLowerCase();
    setState(() {
      if (query.isNotEmpty) {
        filteredList = originalList.where((document) {
          var ilac = document.data() as Map<String, dynamic>;
          return ilac['Ilaç Adı'].toString().toLowerCase().contains(query);
        }).toList();
      } else {
        // Reset the list if the query is empty
        filteredList = List.from(originalList);
      }
    });
  }

  void showAlertDialog(BuildContext context, Map<String, dynamic> ilac) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(ilac['Ilaç Adı'].toString()),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reçete Turu: ${ilac['Reçete Turu'].toString()}'),
              // Add more fields as needed
            ],
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
}
