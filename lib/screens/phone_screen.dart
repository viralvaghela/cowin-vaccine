import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Enter Phone Number',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: textEditingController,
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
              child: ButtonTheme(
                height: 50,
                child: FlatButton(
                  onPressed: () {
                    generateOTP(textEditingController.text);
                  },
                  child: Center(
                      child: Text(
                    "SUBMIT".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green.shade200,
                        offset: Offset(1, -2),
                        blurRadius: 5),
                    BoxShadow(
                        color: Colors.green.shade200,
                        offset: Offset(-1, 2),
                        blurRadius: 5)
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  generateOTP(String number) async {
    var bodyData = jsonEncode(<String, String>{"mobile": "$number"});

    // print(bodyData);
    var res = await http.post(
        Uri.parse("https://cdn-api.co-vin.in/api/v2/auth/public/generateOTP"),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: bodyData);

    if (res.body.toString() == "OTP Already Sent" || res.body.toString()!=" " ) {
      var jsonData = await json.decode(res.body);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PinCodeVerificationScreen(number, jsonData['txnId']),
      ));
    }
  }
}
