import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  static const routeName = '/help';
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hilfe'),
      ),
      body: Center(
        child: Text('Hier entsteht in kürze was!'),
      ),
    );
  }
}
