import 'package:flutter/material.dart';
import 'dart:io';
import 'package:gev_app/utilities/commons.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SupportACause extends StatefulWidget {
  @override
  _SupportACauseState createState() => _SupportACauseState();
}

class _SupportACauseState extends State<SupportACause> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Common.appBar('Support A Cause'),
      bottomNavigationBar: BottomNavbar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingHomeButton(),
      body: WebView(
        initialUrl: 'https://ecovillage.org.in/donation/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
