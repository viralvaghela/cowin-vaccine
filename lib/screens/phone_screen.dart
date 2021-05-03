import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Enter Number "),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: textEditingController,
              ),
            ),
            FlatButton(
                onPressed: () {
                  generateOTP(textEditingController.text);
                },
                child: Text("Submit"))
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

    var jsonData = await json.decode(res.body);

    // print(jsonData);
    // setState(() {});
  }
}
