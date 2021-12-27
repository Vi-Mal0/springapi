import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:springapi/employee/updateemployee.dart';
import 'employeedrawer.dart';
import 'employeemodel.dart';

class getemployees extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return getAllEmployeesState();
  }
}

class getAllEmployeesState extends State<getemployees> {

  Future<List<EmployeeModel>> getEmployees() async {
    var data = await http.get(Uri.parse('http://localhost:8080/getallemployees'));
    var jsonData = json.decode(data.body);

    List<EmployeeModel> employee = [];
    for (var e in jsonData) {
      EmployeeModel employees = EmployeeModel(id: e["id"], lastName: e["lastName"], firstName: e["firstName"]);
      employee.add(employees);
    }
    return employee;
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: FutureBuilder(
        future: getEmployees(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(child: Center(child: Icon(Icons.error)));
          }
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Container(
                    child: Column(
                      children: [
                        Container(
                          child: ListTile(
                            title: Text("name: " + snapshot.data[index].firstname),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(snapshot.data[index])));
                  },
                );
              });
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  EmployeeModel employee;

  DetailPage(this.employee);

  deleteEmployee1(EmployeeModel employee) async {
    final url = Uri.parse('http://localhost:8080/deleteemployee');
    final request = http.Request("DELETE", url);
    request.headers
        .addAll(<String, String>{"Content-type": "application/json"});
    request.body = jsonEncode(employee);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3fada8),
        title: Text(employee.firstName),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    updateEmployee(employee)), (Route<dynamic> route) => false);
              })
        ],
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff3fada8),
        onPressed: () {
          deleteEmployee1(employee);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              employeeDrawer()), (Route<dynamic> route) => false);
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}