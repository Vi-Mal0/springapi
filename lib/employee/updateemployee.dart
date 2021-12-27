import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'employeemodel.dart';
import 'employeedrawer.dart';

class updateEmployee extends StatefulWidget {
  EmployeeModel employee;

  @override
  State<StatefulWidget> createState() {
    return updateEmployeeState(employee);
  }

  updateEmployee(this.employee);
}

Future updateEmployees(
    EmployeeModel employee, BuildContext context) async {
  var Url = "http://localhost:8080/updateemployee";
  var response = await http.put(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(employee));
  String responseString = response.body;
}

class updateEmployeeState extends State<updateEmployee> {
  late EmployeeModel employee;
  final minimumPadding = 5.0;
  late TextEditingController employeeNumber;
  bool _isEnabled = false;
  late TextEditingController firstController;
  late TextEditingController lastController;
  late Future<List<EmployeeModel>> employees;

  updateEmployeeState(this.employee) {
    employeeNumber = TextEditingController(text: this.employee.id.toString());
    firstController = TextEditingController(text: this.employee.firstName);
    lastController = TextEditingController(text: this.employee.lastName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff3fada8),
          title: Text('Update'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => employeeDrawer()));
            },
          ),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(minimumPadding * 2),
                child: ListView(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        controller: employeeNumber,
                        enabled: _isEnabled,
                        decoration: InputDecoration(
                            labelText: 'Employee ID',
                            hintText: 'Enter Employee ID',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        controller: firstController,
                        decoration: InputDecoration(
                            labelText: 'First Name',
                            hintText: 'Enter Your First Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  RaisedButton(
                    color: const Color(0xff3fada8),
                      child: Text('Update Details'),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            employeeDrawer()), (Route<dynamic> route) => false);
                        String firstName = firstController.text;
                        String lastName = lastController.text;
                        EmployeeModel emp = new EmployeeModel(lastName: lastController.text, id: employee.id, firstName: firstController.text);
                        EmployeeModel employees = updateEmployees(emp, context) as EmployeeModel;
                        setState(() {
                          employee = employees;
                        });
                      })
                ]))));
  }
}