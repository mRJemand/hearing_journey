import 'package:flutter/material.dart';
import 'package:hearing_journey/provider/tipps.dart';
import 'package:hearing_journey/screens/questionaire_screen.dart';
import 'package:hearing_journey/screens/tip_detail_list_screen.dart';
import 'package:hearing_journey/widgets/authenticate.dart';
import 'package:hearing_journey/widgets/sign_in.dart';
import 'package:provider/provider.dart';
import './screens/diary_screen.dart';
import './screens/help_screen.dart';
import './screens/profile_screen.dart';
import './screens/settings_screen.dart';
import 'screens/tip_detail_screen.dart';
import 'screens/tips_category_screen.dart';
import './screens/tabs_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

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
        home: Authenticate(),
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
          TippsCategoryScreen.routeName: (context) {
            return TippsCategoryScreen();
          },
          TipDetailScreen.routeName: (context) {
            return TipDetailScreen();
          },
          TipDetailListScreen.routeName: (context) {
            return TipDetailListScreen();
          },
          TabsScreen.routeName: (context) {
            return TabsScreen();
          },
          SignIn.routeName: (context) {
            return SignIn();
          },
        },
        // onGenerateRoute: (settings) {
        //  print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
        // },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (ctx) => TippsCategoryScreen());
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
