import 'package:flutter/material.dart';
import 'package:phone_auth/result.dart';
import 'package:phone_auth/submit.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController name = TextEditingController();
  TextEditingController marks = TextEditingController();
  TextEditingController rollNO = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: name,
            decoration: InputDecoration(hintText: 'name'),
          ),
          TextField(
            controller: marks,
            decoration: InputDecoration(hintText: 'marks'),
          ),
          TextField(
            controller: rollNO,
            decoration: InputDecoration(hintText: 'roll no'),
          ),
          ElevatedButton(
              onPressed: () async {
                // await submit(
                //     name.text, int.parse(marks.text), int.parse(rollNO.text));
                Map<String, dynamic> map = await getData();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => ResultPage(
                              map: map,
                            )));
              },
              child: Text('submit'))
        ],
      ),
    );
  }
}
