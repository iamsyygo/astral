import 'package:flutter/material.dart';

void main() {
  runApp(const AstralApp());
}

class AstralApp extends StatelessWidget {
  const AstralApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astral',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff4186f5)),
        useMaterial3: true,
      ),
      home: const AstralHomePage(title: 'Astral'),
    );
  }
}

class AstralHomePage extends StatefulWidget {
  const AstralHomePage({super.key, required this.title});

  final String title;

  @override
  State<AstralHomePage> createState() => _AstralHomePageState();
}

class _AstralHomePageState extends State<AstralHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
