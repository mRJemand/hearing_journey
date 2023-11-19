import 'package:flutter/material.dart';
import 'package:hearing_journey/dummy_data.dart';
import 'package:hearing_journey/models/category.dart';
import 'package:hearing_journey/models/tipp.dart';
import 'package:hearing_journey/widgets/tip_category_item.dart';

class TippsCategoryScreen extends StatelessWidget {
  static const routeName = '/tipps';
  final List<Category> _places = DUMMY_CATEGORIES.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tipp Kategorien",
        ),
        backgroundColor: Colors.red, // Restored red color for AppBar
      ),
      body: Container(
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
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 8),
          separatorBuilder: (context, index) =>
              SizedBox(height: 8), // Separation between cards
          itemBuilder: (context, index) {
            return TipCategoryItem(
              _places[index].id,
              _places[index].title,
              _places[index].firebase_key,
              _places[index].imageUrl,
            );
          },
          itemCount: _places.length,
        ),
      ),
    );
  }
}
