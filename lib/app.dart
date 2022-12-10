import 'package:flutter/material.dart';
import 'package:onboarding/screens/home_screen.dart';
import 'package:onboarding/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  bool _isAtivo = false;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: _isAtivo ? HomeScreen() : Onboarding_Screen(),
    );
  }

  _initAppVerificaAtividade() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final ativo = prefs.getBool('ativo') ?? false;
    setState(() {
      _isAtivo = ativo;
    });
  }
}