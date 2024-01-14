import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hearing_journey/screens/tabs_screen.dart';
import 'package:hearing_journey/services/auth.dart';

class SignIn extends StatefulWidget {
  static const routeName = '/login';

  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
          Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
        }
      });
    });
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.account_circle_outlined),
              onPressed: () async {
                try {
                  dynamic result = await _auth.signInWithEmailAndPassword(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                  if (result != null) {
                    showSnackbar('Erfolgreich angemeldet!');
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreen.routeName);
                  } else {
                    showSnackbar('Anmeldefehler!');
                  }
                } catch (e) {
                  showSnackbar('Fehler: ${e.toString()}');
                }
              },
              label: Text('Anmelden'),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.no_accounts_outlined),
              onPressed: () async {
                try {
                  dynamic result = await _auth.signInAnon();
                  if (result != null) {
                    showSnackbar('Erfolgreich anonym angemeldet!');
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreen.routeName);
                  } else {
                    showSnackbar('Anmeldefehler!');
                  }
                } catch (e) {
                  showSnackbar('Fehler: ${e.toString()}');
                }
              },
              label: const Text('Als Gast anmelden'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try {
                  dynamic result = await _auth.createUserWithEmailAndPassword(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                  if (result != null) {
                    showSnackbar('Benutzerkonto erfolgreich erstellt!');
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreen.routeName);
                  } else {
                    showSnackbar('Fehler bei der Kontoerstellung.');
                  }
                } catch (e) {
                  showSnackbar('Fehler: ${e.toString()}');
                }
              },
              child: const Text('Registrieren und anmelden'),
            ),
          ],
        ),
      ),
    );
  }
}
