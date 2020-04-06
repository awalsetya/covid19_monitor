import 'package:flutter/material.dart';
import './screens/home_page.dart';
import './providers/homeprovider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(providers: [
  ChangeNotifierProvider(create: (_)=> HomeProvider()),
], child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid_monitor',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}

