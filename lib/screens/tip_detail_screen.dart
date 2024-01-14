import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hearing_journey/dummy_data.dart';
import 'package:hearing_journey/models/tip.dart';
import 'package:hearing_journey/widgets/tip_detail.dart';
import 'package:hearing_journey/widgets/tip_category_item.dart';
import 'package:hearing_journey/widgets/tips_list.dart';
import 'package:path_provider/path_provider.dart';

class TipDetailScreen extends StatefulWidget {
  static const routeName = '/tip-detail';

  // @override
  // State<TipDetailScreen> createState() => _TipDetailScreenState();

  @override
  State<StatefulWidget> createState() => _TipDetailScreenState();
}

class _TipDetailScreenState extends State<TipDetailScreen> {
  final CollectionReference tips =
      FirebaseFirestore.instance.collection('tips');
  late QuerySnapshot? tipsSnapshot;
  int currentTipsIndex = 0;
  String? userCategory;

  List<Tip>? allTips;
  TipCategoryItem? tipCategoryItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    tipCategoryItem =
        ModalRoute.of(context)?.settings.arguments as TipCategoryItem;

    print('${tipCategoryItem!.title} ${tipCategoryItem!.firebase_key} ');
    tipsSnapshot = null;
    await loadKennzahlenData();
    _loadTips();
  }

  Future<void> loadKennzahlenData() async {
    try {
      // Pfad zum internen Speicher erhalten
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String kennzahlenPath = '${appDocDir.path}/kennzahlen.json';
      print(kennzahlenPath);

      // Überprüfen, ob die Datei existiert
      if (await File(kennzahlenPath).exists()) {
        // Laden der JSON-Datei
        String jsonContent = await File(kennzahlenPath).readAsString();
        // Dekodieren des JSON-Inhalts
        dynamic decodedJson = jsonDecode(jsonContent);

        setState(() {
          // Aktualisieren des Titels basierend auf dem Wert aus der JSON-Datei

          userCategory = decodedJson['highestCategory'];
          print('folgende userCategory: $userCategory');
        });
      } else {
        userCategory = null;
        print('keine userCategory');
      }
    } catch (e) {
      print('Fehler beim Laden der kennzahlen.json-Datei: $e');
    }
  }

  Future<void> _loadTips() async {
    try {
      Query query = tips; //.where(tipCategoryItem!.firebase_key, isEqualTo: 1);

      if (userCategory != null && tipCategoryItem!.firebase_key != null) {
        query = query.where(tipCategoryItem!.firebase_key!, isEqualTo: 1);
      }

      if (userCategory != null) {
        query = query.where(userCategory!, isEqualTo: 1);
      }

      QuerySnapshot snapshot = await query.get();

      if (snapshot != null) {
        setState(() {
          tipsSnapshot = snapshot;
          allTips = createTipsList(snapshot);
          allTips?.sort((a, b) => a.number.compareTo(b.number));
        });
      }
    } catch (e) {
      print('Error loading tips: $e');
    }
    print('i: $currentTipsIndex total: ${allTips!.length}');
  }

  List<Tip> createTipsList(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((document) {
      return Tip.fromDocumentSnapshot(document);
    }).toList();
  }

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple.shade600,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: child,
    );
  }

  bool isNextTipAvailable() {
    return currentTipsIndex < allTips!.length - 1;
  }

  void nextTip() {
    setState(() {
      if (isNextTipAvailable()) {
        currentTipsIndex++;
      }
    });
  }

  bool isPreviousTipAvailable() {
    return currentTipsIndex > 0;
  }

  void previousTip() {
    setState(() {
      if (isPreviousTipAvailable()) {
        currentTipsIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showNoTipsText = false;
    var currentTip;

    if (tipsSnapshot == null || allTips == null) {
      return Center(child: CircularProgressIndicator());
    } else if (tipsSnapshot!.docs.length == 0 || allTips!.isEmpty) {
      setState(() {
        showNoTipsText = true;
      });
    } else {
      currentTip = allTips![currentTipsIndex];
    }

    // final selectedTipp = DUMMY_TIPPS.firstWhere((tipp) => tipp.nr == tippId);
    return Scaffold(
      appBar: AppBar(
        title: Text(tipCategoryItem!.title),
      ),
      body:
          // SingleChildScrollView(
          //   child: Column(
          //     children: <Widget>[
          // Container(
          //   height: 300,
          //   width: double.infinity,
          // child: Image.network(
          //   selectedTipp.imageUrl,
          //   fit: BoxFit.cover,
          // ),
          // ),
          // buildSectionTitle(context, '${selectedTipp.title}'),
          showNoTipsText
              ? Center(child: Text('Keine Tipps dazu'))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      //   Text(json.encode(allTips)),

                      // TippDetailWidget(
                      //   currentTip: currentTip,
                      //   isNextTipAvailable: isNextTipAvailable(),
                      //   isPreviousTipAvailable: isPreviousTipAvailable(),
                      //   nextTip: nextTip,
                      //   previousTip: previousTip,
                      //   tipCategoryItem: tipCategoryItem,
                      //   currentTipsIndex: currentTipsIndex,
                      // ), asdasdasdasdasd
                      // ListTile(
                      //   //contentPadding: EdgeInsets.all(<some value here>),//change for side padding
                      //   title: Row(
                      //     children: <Widget>[
                      //       Expanded(
                      //         child: ElevatedButton(
                      //           onPressed: isPreviousTipAvailable()
                      //               ? () => previousTip()
                      //               : null,
                      //           child: const Text('zurück'),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 8,
                      //       ),
                      //       Expanded(
                      //         child: ElevatedButton(
                      //           onPressed: isNextTipAvailable()
                      //               ? () => nextTip()
                      //               : null,
                      //           child: const Text('weiter'),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
      // buildContainer(Text('${selectedTipp.tipp}'))
      //   ],
      // ),
      // ),
    );
  }
}
