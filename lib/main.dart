import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_thermometer/thermometer.dart';
import 'package:flutter_thermometer/thermometer_widget.dart';
import 'package:internet_rzeczy/fetch.dart';

import 'custom_scale_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Czujniki',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dane z czujników'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double width = 200;
  double height = 200;
  double temp = 0;
  double minTemp = -50;
  double maxTemp = 50;
  double humidity = 0;
  double pressure = 0;
  double altitude = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(milliseconds: 250), (Timer timer) async {
      var data = await fetchData();
      setState(() {
        temp = data.temperature.toPrecision(2);
        humidity = data.humidity.toPrecision(2);
        pressure = data.pressure.toPrecision(2);
        altitude = data.altitude.toPrecision(2);
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Temperatura:',
            ),
            SizedBox(
                width: width,
                height: height,
                child: Thermometer(
                  value: temp,
                  minValue: minTemp,
                  maxValue: maxTemp,
                  scale: CustomScaleProvider(),
                )),
            Text(
              '${temp}\u00B0C',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              'Wilgotność:',
            ),
            Text(
              '${humidity}% rH',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              'Ciśnienie:',
            ),
            Text(
              '${pressure} hPa',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              'Wysokość:',
            ),
            Text(
              '${altitude}m n.p.m.',
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
    );
  }
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
