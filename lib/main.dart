import 'package:flutter/material.dart';
import 'package:hearing_journey/provider/tipps.dart';
import 'package:hearing_journey/screens/questionaire_screen.dart';
import 'package:provider/provider.dart';
import './screens/diary_screen.dart';
import './screens/help_screen.dart';
import './screens/home_screen.dart';
import './screens/profile_screen.dart';
import './screens/settings_screen.dart';
import './screens/tipp_detail_screen.dart';
import './screens/tipps_screen.dart';
import './screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TippsProvider>(
          create: (_) => TippsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'SIGNIA',
        theme: ThemeData(
          canvasColor: Colors.white,
          fontFamily: 'Releway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyMedium: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                titleLarge: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
              .copyWith(secondary: Colors.amber),
        ),
        home: TabsScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          DiaryScreen.routeName: (context) {
            return DiaryScreen();
          },
          QuestionaireScreen.routeName: (context) {
            return QuestionaireScreen();
          },
          HelpScreen.routeName: (context) {
            return HelpScreen();
          },
          ProfileScreen.routeName: (context) {
            return ProfileScreen();
          },
          SettingsScreen.routeName: (context) {
            return SettingsScreen();
          },
          TippsScreen.routeName: (context) {
            return TippsScreen();
          },
          TippDetailScreen.routeName: (context) {
            return TippDetailScreen();
          },
        },
        // onGenerateRoute: (settings) {
        //  print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
        // },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (ctx) => TippsScreen());
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hearing Jorney'),
      ),
      body: Center(
        child: Text('Navigation Time!'),
      ),
    );
  }
}
