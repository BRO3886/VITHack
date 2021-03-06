import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vit_hack/Presentation/util.dart';
import 'package:vit_hack/models/sharedPref.dart';
import 'package:vit_hack/pages/contactUsPage.dart';
import 'package:vit_hack/pages/homePage.dart';
import 'package:vit_hack/pages/loginScreen.dart';
import 'package:vit_hack/pages/partnersPage.dart';
import 'package:vit_hack/pages/qrCodePage.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:vit_hack/pages/introductoryPage.dart';
import 'dart:io';

import 'package:vit_hack/pages/splashScreen.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(new MyApp());
  }

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) =>
        MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), child: child),
        title: 'VITHack',
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home : SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/start':(BuildContext context)=>SplashScreen(),
          '/homepage': (BuildContext context) => MyHomePage(),
          '/intro':(BuildContext context)=>IntroScreen(),
          '/login':(BuildContext context)=>LoginScreen()
        }
     );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.personID, this.personName}) : super(key: key);

  String personName, personID;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  TextEditingController controller = TextEditingController();

  SharedPreferencesTest s =new SharedPreferencesTest();

  int _selectedIndex = 0;
  final _widgetOptions = [
    HomePage(),
    PartnersPage(),
    QRCodePage(),
    ContactUsPage()
  ];


  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();

}


  bool boolToString(String value){
    if(value == "true"){
      return true;
    }
    else if(value == "false"){
      return false;
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit the application'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => exit(0),
            child: new Text('Yes'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: new Text('No'),
          ),
        ],
      ),
    ) ?? false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
      onWillPop: _onWillPop,
        child : Scaffold(
          backgroundColor: background,
          body:_widgetOptions[_selectedIndex],
          bottomNavigationBar: 
            BottomNavigationBar(
              items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon:Icon(Icons.home,color: Colors.black,), activeIcon: Icon(Icons.home,color: Colors.blue,),title: Text("Home")),
              BottomNavigationBarItem(icon:Icon(Icons.info,color: Colors.black), activeIcon: Icon(Icons.info,color: Colors.blue,), title:Text("Partners")),
              BottomNavigationBarItem(icon:Icon(Icons.filter_center_focus,color: Colors.black), activeIcon: Icon(Icons.filter_center_focus,color: Colors.blue,),title:Text("QR Code")),
              BottomNavigationBarItem(icon:Icon(Icons.phone,color: Colors.black), activeIcon: Icon(Icons.phone,color: Colors.blue,),title:Text("Contact Us")),
              ],
              currentIndex: _selectedIndex,
                fixedColor: Colors.blue,
                onTap: _onItemTapped,
            ),
     ) );
  }
}