import 'package:flutter/material.dart';
import 'package:springapi/employee/registeremployee.dart';
import 'getempdata.dart';

class employeeDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return employeeDrawerState();
  }
}

class employeeDrawerState extends State<employeeDrawer> {
  final minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3fada8),
        title: Text('Stud'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => employeeDrawer()));
              })
        ],
      ),
      body: Center(child: getemployees()),
      floatingActionButton: FloatingActionButton(
        backgroundColor:const Color(0xff3fada8),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => registerEmployee()));
        },
      ),
    );
  }
}