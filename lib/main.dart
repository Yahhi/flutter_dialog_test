import 'package:async/async.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _alertIsActive = false;
  DateTime dialogStarted;

  void _showMessage() async {
    _alertIsActive = true;
    dialogStarted = DateTime.now();

    Duration _timerDuration = new Duration(seconds: 5);
    RestartableTimer _timer =
        new RestartableTimer(_timerDuration, _dismissTimer);
    _timer.reset();

    int result = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Dismiss or wait for 5 seconds"),
              content: Text(
                  "Wait to see that dialog can disappear without any action after 5 seconds of inactivity"),
              actions: <Widget>[
                FlatButton(
                  onPressed: _dismissTimer,
                  child: Text("Dismiss"),
                )
              ],
            ));
    setState(() {
      _counter = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _counter == 0
                  ? "Please click on button"
                  : 'You dismissed dialog after $_counter milliseconds',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showMessage,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _dismissTimer() {
    if (_alertIsActive) {
      Navigator.of(context).pop(DateTime.now().millisecondsSinceEpoch -
          dialogStarted.millisecondsSinceEpoch);
      _alertIsActive = false;
    }
  }
}
