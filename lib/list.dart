import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<dynamic> userList = [];

  Future<void> _fetchUsers() async {
    var response = await http
        .get(Uri.parse('https://reqres.in/api/users?page=1&per_page=12'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        userList = data['data'];
        userList.sort((a, b) => a['first_name'].compareTo(b['first_name']));
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch users. Please try again.'),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 245, 170, 57))),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
              ),
            ),
          ],
        ),
      );
    }
  }

  void _deleteUser(int index) {
    setState(() {
      userList.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        shadowColor: Color.fromARGB(255, 233, 210, 80),
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(70))),
        backgroundColor: Color.fromARGB(255, 255, 202, 58),
        centerTitle: true,
        title: Text(
          'Users List',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 2,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) => SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 255, 202, 58)),
                          borderRadius: BorderRadius.circular(70)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage('${userList[index]['avatar']}'),
                          ),
                          title: Text(
                            '${userList[index]['first_name']} ${userList[index]['last_name']}',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            color: Color.fromARGB(255, 255, 202, 58),
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 202, 63),
                                        width: 6.0,
                                        style: BorderStyle.solid,
                                        strokeAlign:
                                            BorderSide.strokeAlignInside),
                                  ),
                                  elevation: 3,
                                  actionsPadding: const EdgeInsets.only(),
                                  actionsAlignment:
                                      MainAxisAlignment.spaceAround,
                                  backgroundColor:
                                      Color.fromARGB(255, 217, 216, 214),
                                  title: Text('Delete User'),
                                  content: Text('Are you sure ?'),
                                  actions: [
                                    Column(
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              202,
                                                              58))))),
                                          onPressed: () {
                                            _deleteUser(index);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Yes'),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              202,
                                                              58))))),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('No'),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
