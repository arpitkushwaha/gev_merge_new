import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class InternetConnection extends StatefulWidget {
  @override
  _InternetConnectionState createState() => _InternetConnectionState();
}

class _InternetConnectionState extends State<InternetConnection> {
  @override
  void initState() {
    super.initState();
    var connectivityResult = (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
    } else {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _showAlertDialog(context));
    }
  }

  Widget build(BuildContext context) {}

  void _showAlertDialog(context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        // This closes the dialog. `context` means the BuildContext, which is
        // available by default inside of a State object. If you are working
        // with an AlertDialog in a StatelessWidget, then you would need to
        // pass a reference to the BuildContext.
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Internet not found"),
      content: Text("Please check the connection. and try again."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
