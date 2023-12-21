import 'package:example/navigation/secondRoute.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        title: "Example",
        initialRoute: '/',
        routes: {
          // '/': (context) => Home(todo: []),
          '/': (context) => SecondRoute(),
        },
      ),
    );
