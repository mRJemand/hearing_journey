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
    // TODO: implement initState
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
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.account_circle_outlined),
                onPressed: () async {
                  dynamic result = await _auth.signInWithEmailAndPassword(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );

                  if (result != null) {
                    print('User logged in: $result');
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreen.routeName);
                  } else {
                    print('Error: Not logged in!');
                  }
                },
                label: Text('Login with Username & Password'),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.no_accounts_outlined),
                onPressed: () async {
                  dynamic result = await _auth.signInAnon();
                  if (result != null) {
                    print('User logged in anonymously: $result');
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreen.routeName);
                  } else {
                    print('Error: Not logged in!');
                  }
                },
                label: Text('Login Anonymously'),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                dynamic result = await _auth.createUserWithEmailAndPassword(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                );
                if (result != null) {
                  print('User created: $result');
                } else {
                  print('Error: Not created!');
                }
              },
              child: Text('Create Username & Password'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                dynamic result = await _auth.signOut();
                if (result != null) {
                  print('User signed out: $result');
                } else {
                  print('Error: Not signed out!');
                }
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
