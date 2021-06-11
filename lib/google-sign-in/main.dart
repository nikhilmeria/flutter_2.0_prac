import 'package:coffee_shop_ui/screens/google-signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => GoogleSignInProvider(),
      child: MaterialApp(
        home: MyApp(),
        title: "Flutter 2.2",
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Dashboard();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "we2",
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        child: MaterialButton(
          onPressed: () {
            print("in Process");
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.googleLogin();
          },
          child: Text(
            'Sign In with Google',
          ),
        ),
      ),
    );
  }
}
