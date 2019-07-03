import 'package:flutter/cupertino.dart';

import 'package:flutter_dororo_tabs/flutter_dororo_tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              DororoTab(
                text: '1111',
                icon: Icon(CupertinoIcons.add_circled),
              ),
              DororoTab(
                text: '2222',
                icon: Icon(CupertinoIcons.double_music_note),
              ),
              DororoTab(
                text: '3333',
                icon: Icon(CupertinoIcons.folder_solid),
              ),
              Text('插件开始编写'),
            ],
          ),
        ),
      ),
    );
  }
}
