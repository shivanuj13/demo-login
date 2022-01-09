import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<FirebaseApp>? _firebaseApp;
  final TextEditingController _phonenum = TextEditingController();
  final TextEditingController _otp = TextEditingController();

  bool otpSent=false;
  bool _isLoggedIn = false;

  String? _verificationId;


  void signin() async {
    PhoneAuthCredential credential= PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: _otp.text);
    
    await FirebaseAuth.instance.signInWithCredential(credential);

    setState(() {
      _isLoggedIn=true;
    });

  }


  void getOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _phonenum.text, 
      verificationCompleted: verificationCompleted, 
      verificationFailed: verificationFailed, 
      codeSent: codeSent, 
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

      setState(() {
        otpSent=true;
      });
  }

  void codeAutoRetrievalTimeout (String verificationId) {
    setState(() {
      _verificationId=verificationId;
    });

  }

  void codeSent(String verificationId , int? a) {
    setState(() {
      _verificationId=verificationId;
    });
  }

  void verificationFailed(FirebaseAuthException exception) {
    print(exception.message);
  }

  void verificationCompleted(PhoneAuthCredential credential) async 
  {
    await FirebaseAuth.instance.signInWithCredential(credential);
    setState(() {
      _isLoggedIn=true;
    });
  }

  @override
  void initState() {
    super.initState();
    _firebaseApp = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _firebaseApp,
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return const CircularProgressIndicator();
              }
              return Center(
                  child: _isLoggedIn?Text(FirebaseAuth.instance.currentUser!.uid):
                  
                  otpSent?Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _otp,
                    decoration: const InputDecoration(hintText: "enter otp"),
                  ),
                  ElevatedButton(onPressed: signin, child: const Text('sign in'))
                ],
              ):
                  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _phonenum,
                    decoration:  const InputDecoration(hintText: "enter phone no"),
                  ),
                  ElevatedButton(onPressed: getOtp, child: const Text('get otp'))
                ],
              ));
            }));
  }
}
