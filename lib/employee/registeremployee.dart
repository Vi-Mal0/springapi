import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:springapi/employee/employeedrawer.dart';

import 'employeemodel.dart';

class registerEmployee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return registerEmployeeState();
  }
}

Future registerEmployees(
    String firstName, String lastName, BuildContext context) async {
  var Url = "http://localhost:8080/addemployee";
  var response = await http.post(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "firstName": firstName,
        "lastName": lastName,
      }));
}

class registerEmployeeState extends State<registerEmployee> {
  final minimumPadding = 5.0;

  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();

  late EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3fada8),
        title: Text("Register"),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    controller: firstController,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              RaisedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        employeeDrawer()), (Route<dynamic> route) => false);
                    String firstName = firstController.text;
                    String lastName = lastController.text;
                    EmployeeModel employees = registerEmployees(firstName, lastName, context) as EmployeeModel;
                    firstController.text = '';
                    lastController.text = '';
                    setState(() {
                      employee = employees;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
