import 'package:flutter/material.dart';
import 'package:hearing_journey/dummy_data.dart';
import 'package:hearing_journey/widgets/tipp_item.dart';
import 'package:hearing_journey/widgets/tipps_list.dart';

class TippDetailScreen extends StatelessWidget {
  static const routeName = '/tipp-detail';

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

  @override
  Widget build(BuildContext context) {
    TippItem args = ModalRoute.of(context)?.settings.arguments as TippItem;

    // final selectedTipp = DUMMY_TIPPS.firstWhere((tipp) => tipp.nr == tippId);
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
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
          TippsList(selectedTippCategory: args.title),
      // buildContainer(Text('${selectedTipp.tipp}'))
      //   ],
      // ),
      // ),
    );
  }
}
