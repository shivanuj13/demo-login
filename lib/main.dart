import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/form.dart';
import 'package:phone_auth/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
    home: FormPage(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _otp = TextEditingController();

  bool _isotpSent = false;

  String? _verificationId;

  Future<void> signIn() async {
    UserCredential? userCredential;
    PhoneAuthCredential credential = await PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: _otp.text);
    userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    userCredential == null
        ? print("something went wrong")
        : Navigator.push(
            context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }

  Future<void> getOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${_phone.text}',
      verificationCompleted: verificationComplete,
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        setState(() {
          _isotpSent = false;
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _isotpSent = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
          _isotpSent = true;
        });
      },
    );
  }

  void verificationComplete(PhoneAuthCredential credential) {
    setState(() {
      FirebaseAuth.instance.signInWithCredential(credential);
      _isotpSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isotpSent
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _otp,
                  decoration: InputDecoration(hintText: 'enter otp'),
                ),
                ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    child: Text("sign in"))
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _phone,
                  decoration: InputDecoration(hintText: 'enter phone no'),
                ),
                ElevatedButton(
                    onPressed: () {
                      getOtp();
                    },
                    child: Text("get otp"))
              ],
            ),
    );
  }
}
