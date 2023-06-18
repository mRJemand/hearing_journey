import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hearing_journey/models/tipp.dart';
import 'package:http/http.dart' as http;

class TippsProvider with ChangeNotifier {
  List<Tipp> _data = [];

  List get data => _data;

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://hearing-journey-default-rtdb.europe-west1.firebasedatabase.app/tipps.json'));

    if (response.statusCode == 200) {
      // Bei Erfolg, parse die Antwort

      List<dynamic> data = jsonDecode(response.body);
      _data = data.map((item) => Tipp.fromJson(item)).toList();

      notifyListeners(); // Benachrichtigen Sie die Abonnenten, dass sich die Daten geändert haben
    } else {
      // Bei Misserfolg, werfen Sie eine Exception
      throw Exception('Failed to load data from Firebase');
    }
  }
}
