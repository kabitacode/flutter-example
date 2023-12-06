import 'package:flutter/material.dart';
import 'dart:async';

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyStatefulWidget(title: 'State Change Demo'),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key, required this.title});

  final String title;

  @override
  State<MyStatefulWidget> createState() => _MyStateFullWidgetState();
}

class _MyStateFullWidgetState extends State<MyStatefulWidget> {
  bool showText = true;
  bool toggleState = true;

  late final String title;

  Timer? t2;

  void toggleBlinkState() {
    setState(() {
      toggleState = !toggleState;
    });

    if (!toggleState) {
      t2 = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
        toggleShow();
      });
    } else {
      t2?.cancel();
    }
  }

  void toggleShow() {
    setState(() {
      showText = !showText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (showText)
            const Text('This execution will be done before you can blink.'),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
                onPressed: toggleBlinkState,
                child: toggleState ? const Text('blink') : const Text('Stop')),
          )
        ],
      ),
    );
  }
}
