import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hearing_journey/models/tipp.dart';
import 'package:hearing_journey/provider/tipps.dart';
import 'package:provider/provider.dart';

class TippsList extends StatefulWidget {
  @override
  _TippsListState createState() => _TippsListState();

  String selectedTippCategory;

  TippsList({required this.selectedTippCategory});
}

class _TippsListState extends State<TippsList> {
  late String title;
  late String userCategory;
  String uricaResult = '';

  @override
  void initState() {
    super.initState();
    // Laden der kennzahlen.json-Datei
    Provider.of<TippsProvider>(context, listen: false).fetchData();
    loadKennzahlenData();
  }

  Future<void> loadKennzahlenData() async {
    try {
      // Pfad zum internen Speicher erhalten
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String kennzahlenPath = '${appDocDir.path}/kennzahlen.json';

      // Überprüfen, ob die Datei existiert
      if (await File(kennzahlenPath).exists()) {
        // Laden der JSON-Datei
        String jsonContent = await File(kennzahlenPath).readAsString();
        // Dekodieren des JSON-Inhalts
        dynamic decodedJson = jsonDecode(jsonContent);
        userCategory = decodedJson['highestCategory'];
        if (userCategory != null) {
          // Erstellen der uricaResult Variable basierend auf userCategory
          if (userCategory == 'Precontemplation') {
            uricaResult = 'A';
          } else if (userCategory == 'Contemplation' ||
              userCategory == 'Action') {
            uricaResult = 'B';
          }
          setState(() {
            // Aktualisieren des Titels basierend auf dem Wert aus der JSON-Datei
            title = 'Ihre Phase: $userCategory';
          });
        } else {
          title = 'Noch kein Hörtest verfügbar';
        }
      }
    } catch (e) {
      print('Fehler beim Laden der kennzahlen.json-Datei: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialisieren des Titels mit dem Standardwert
    title = 'Noch kein Hörtest verfügbar';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TippsProvider>(
      builder: (context, provider, child) {
        // Filtern der Tipps basierend auf uricaResult und ausgewählter Kategorie
        List<Tipp> filteredTipps = uricaResult == 'A'
            ? provider.data
                .where((tipp) => tipp.a == 1 && checkTippCategory(tipp))
                .toList()
                .cast<Tipp>()
            : uricaResult == 'B'
                ? provider.data
                    .where((tipp) => tipp.b == 1 && checkTippCategory(tipp))
                    .toList()
                    .cast<Tipp>()
                : (provider.data as List<
                    Tipp>); // Vollständige Liste anzeigen, wenn uricaResult keinen Wert hat oder einen anderen Wert als 'A' oder 'B' hat

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey.shade900,
                Colors.grey.shade800,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 8), // Separation between cards
                  itemCount: filteredTipps.length,
                  itemBuilder: (context, index) {
                    final tipp = filteredTipps[index];

                    return Card(
                      color: Colors.white.withOpacity(1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          'Tipp Nr. ${tipp.nr}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          tipp.tipp ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool checkTippCategory(Tipp tipp) {
    if (widget.selectedTippCategory == 'Alltag') {
      return tipp.alltag == 1;
    } else if (widget.selectedTippCategory == 'Bei der Arbeit') {
      return tipp.beiDerArbeit == 1;
    } else if (widget.selectedTippCategory == 'Hilfe holen') {
      return tipp.hilfeHolen == 1;
    } else if (widget.selectedTippCategory == 'Kommunikation') {
      return tipp.kommunikation == 1;
    } else if (widget.selectedTippCategory == 'Reisen') {
      return tipp.reisen == 1;
    } else if (widget.selectedTippCategory == 'Unterhaltung und Kultur') {
      return tipp.unterhaltungKultur == 1;
    } else if (widget.selectedTippCategory == 'Unterwegs') {
      return tipp.unterwegs == 1;
    } else if (widget.selectedTippCategory == 'Zu Hause') {
      return tipp.zuHause == 1;
    }
    return false;
  }
}
