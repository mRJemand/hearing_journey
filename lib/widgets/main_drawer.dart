import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hearing_journey/screens/diary_screen.dart';
import 'package:hearing_journey/screens/help_screen.dart';
import 'package:hearing_journey/screens/home_screen.dart';
import 'package:hearing_journey/screens/profile_screen.dart';
import 'package:hearing_journey/screens/questionaire_screen.dart';
import 'package:hearing_journey/screens/settings_screen.dart';
import 'package:hearing_journey/screens/tips_category_screen.dart';

class MainDrawer extends StatelessWidget {
  Future<bool> isUserLoggedInAndNotAnonymously() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;

    if (user != null && !user.isAnonymous) {
      // The user is logged in anonymously
      return true;
    } else {
      // The user is not logged in or is logged in using another method
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade900,
              Colors.grey.shade600,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Colors.red,
              child: Text(
                'Menu',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildListTile(
              'Home',
              Icons.home,
              () {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              },
            ),
            buildListTile(
              'Fragebogen',
              Icons.help,
              () {
                Navigator.of(context).pushNamed(QuestionaireScreen.routeName);
              },
            ),
            buildListTile(
              'Tipps',
              Icons.edit,
              () {
                Navigator.of(context).pushNamed(TippsCategoryScreen.routeName);
              },
            ),
            FutureBuilder<bool>(
              future: isUserLoggedInAndNotAnonymously(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  bool isLoggedInAnonymously = snapshot.data ?? false;

                  return isLoggedInAnonymously
                      ? buildListTile(
                          'Einstellungen',
                          Icons.settings,
                          () {
                            Navigator.of(context)
                                .pushNamed(SettingsScreen.routeName);
                          },
                        )
                      : Container();
                }
              },
            ),
            buildListTile(
              'Profil',
              Icons.person,
              () {
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              },
            ),
            buildListTile(
              'Hilfe',
              Icons.help,
              () {
                Navigator.of(context).pushNamed(HelpScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(String title, IconData icon, VoidCallback? tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onTap: tapHandler,
    );
  }
}
