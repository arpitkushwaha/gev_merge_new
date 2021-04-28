import 'package:flutter/material.dart';
import 'package:gev_app/controllers/usertype_controller.dart';
import 'package:gev_app/utilities/preferences.dart';
import 'package:gev_app/views/home.dart';
import 'package:gev_app/views/register.dart';
import 'package:gev_app/utilities/textFields.dart';
import 'package:gev_app/utilities/validation.dart';
import 'package:gev_app/controllers/login_controller.dart';
import 'package:gev_app/models/user.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//  _formKey and _autoValidate
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // bool _autoValidate = false;
  String phoneNo;
  String password;

  LogInController logInController = LogInController();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          backgroundColor: Colors.grey[100],
          title: new Text(
            'Login',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_image.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: new SingleChildScrollView(
              child: new Container(
                margin: new EdgeInsets.all(15.0),
                child: new Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  // autovalidate: _autoValidate,
                  child: formUI(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return new Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: new TextFormField(
            decoration: buildInputDecoration(Icons.phone, 'Contact No.'),
            keyboardType: TextInputType.phone,
            validator: validatePhoneNo,
            onSaved: (String val) {
              phoneNo = val;
            },
          ),
        ),
        new SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: new TextFormField(
            decoration: buildInputDecoration(Icons.lock, 'Password'),
            keyboardType: TextInputType.text,
            // validator: validatePassword,
            onSaved: (String val) {
              password = val;
            },
          ),
        ),
        new SizedBox(
          height: 50.0,
        ),
        FractionallySizedBox(
          widthFactor: 0.9,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              const Radius.circular(15.0),
            ),
            child: new TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.deepOrange[900]),
                // minimumSize: MaterialStateProperty.all(),
              ),
              onPressed: _validateInputs,
              child: new Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
        new SizedBox(
          height: 20.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Here for the first time? '),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Register()));
              },
              child: Text(
                'SignUp',
                style: TextStyle(
                  color: Colors.deepPurpleAccent[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _validateInputs() async {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      Preferences preferences = Preferences();

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String userJson = preferences.getPreferences(Preferences.userKey);

      // preferences.setPreferences('isLoggedIn', "false");
      await logInController
          .login(new User(userPhone: int.parse(phoneNo), password: password));
      Future.delayed(const Duration(milliseconds: 2000), () {
        print(preferences.getPreferences("isLoggedIn"));

        if (preferences.getPreferences('isLoggedIn') == "true") {
          print("welcome");
          UserType().setwalkInPref();
          preferences.setPreferences('isValidWalkin', 'true');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
        } else {
          _showAlertDialog();
        }
      });
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        // _autoValidate = true;
      });
    }
  }

  void _showAlertDialog() {
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
      title: Text("User not found"),
      content: Text("Please check the number and try again."),
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
