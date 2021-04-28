import 'package:flutter/material.dart';
import 'package:gev_app/controllers/usertype_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gev_app/utilities/textFields.dart';
import 'package:gev_app/utilities/validation.dart';
import 'package:gev_app/controllers/register_controller.dart';
import 'package:gev_app/models/user.dart';
import 'package:gev_app/utilities/internet_connection.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Register> {
//  _formKey and _autoValidate
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String name;
  String email;
  String countryCode;
  String phoneNo;
  String password;

  RegisterController registerController = RegisterController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => InternetConnection);
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
          backgroundColor: Colors.grey[100],
          title: new Text(
            'Register',
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
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                new SingleChildScrollView(
                  child: new Container(
                    margin: new EdgeInsets.all(10.0),
                    child: new Form(
                      key: _formKey,
                      autovalidate: _autoValidate,
                      child: FormUI(),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Have an acoount?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', ModalRoute.withName('/login'));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.deepPurpleAccent[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      UserType().setskipUser();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', ModalRoute.withName('/home'));
                    },
                    child: Text(
                      'Skip>>',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget FormUI() {
    return new Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new TextFormField(
            decoration: buildInputDecoration(Icons.person_pin, 'Name'),
            keyboardType: TextInputType.text,
            validator: validateName,
            onSaved: (String val) {
              name = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new TextFormField(
            decoration: buildInputDecoration(Icons.phone, 'Country Code.'),
            keyboardType: TextInputType.number,
            // validator: validatePhoneNo,
            onSaved: (String val) {
              countryCode = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new TextFormField(
            decoration: buildInputDecoration(Icons.phone, 'Contact No.'),
            keyboardType: TextInputType.phone,
            validator: validatePhoneNo,
            onSaved: (String val) {
              phoneNo = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new TextFormField(
            decoration: buildInputDecoration(Icons.email, 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            onSaved: (String val) {
              email = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new TextFormField(
            obscureText: true,
            decoration: buildInputDecoration(Icons.lock, 'Password'),
            keyboardType: TextInputType.visiblePassword,
            // validator: validatePhoneNo,
            onSaved: (String val) {
              password = val;
            },
          ),
        ),
        new SizedBox(
          height: 30.0,
        ),
        FractionallySizedBox(
          widthFactor: 0.9,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              const Radius.circular(10.0),
            ),
            child: new TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.deepOrange[900]),
                // minimumSize: MaterialStateProperty.all(),
              ),
              onPressed: _validateInputs,
              child: new Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _validateInputs() async {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();

      await registerController.register(new User(
          userEmail: email,
          userName: name,
          userPhoneCountryCode: int.parse(countryCode),
          userAddress: 'test',
          userDob: '2021-03-18',
          password: password,
          userPhone: int.parse(phoneNo)));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      // var now = DateTime.now();
      // prefs.setString('prev_date', now.toString());
      print('is valid walkin' + prefs.getString('isValidWalkin'));
      prefs.getString('isValidWalkin');
      UserType().setwalkInPref();
      if (prefs.getString('isValidWalkin') == "true") {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'));
      }
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

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
