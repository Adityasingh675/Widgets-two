import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: HomePage(),
      ),
    );

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback _showPersBottomSheetCallback;
  @override

  void initState() {
    super.initState();
    _showPersBottomSheetCallback = _showBottomSheet;
  }

  void _showBottomSheet () {
    setState(() {
      _showPersBottomSheetCallback = null;
    });
    _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        height: 200.0,
        color: Colors.deepPurple,
        child: Center(
          child: Text("Hi BottomSheet"),
        ),
    );
    }).closed.whenComplete(() {
      if (mounted) {
        setState(() {
          _showPersBottomSheetCallback = _showBottomSheet;
        });
      }
    });
  }

  void _showModalSheet () {
    showModalBottomSheet(context: context, builder: (builder) {
      return Container(
        color: Colors.purple,
        child: Center(
          child: Text("Hi ModalSheet"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Flutter bottomsheet demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Persistent'),
              onPressed: _showPersBottomSheetCallback,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
            ),
            RaisedButton(
              child: Text('Modal'),
              onPressed: _showModalSheet,
            ),
          ],
        ),
      ),
    );
  }
}
