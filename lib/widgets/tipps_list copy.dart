import 'package:flutter/material.dart';
import 'package:hearing_journey/provider/tipps.dart';
import 'package:provider/provider.dart';

class TippsList extends StatefulWidget {
  @override
  _TippsListState createState() => _TippsListState();
}

class _TippsListState extends State<TippsList> {
  @override
  void initState() {
    super.initState();
    // Call fetch data when this widget is initialized.
    Provider.of<TippsProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TippsProvider>(
      builder: (context, provider, child) {
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
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 8),
            separatorBuilder: (context, index) =>
                SizedBox(height: 8), // Separation between cards
            itemCount: provider.data.length,
            itemBuilder: (context, index) {
              final tipp = provider.data[index];

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
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    tipp.tipp ?? '',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade900),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
