import 'package:application/db/databaseHelper.dart';
import 'package:application/views/home.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  List recordsReciveSave = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile',
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var recordsRecive = await dbHelper.selectData();
                recordsReciveSave = recordsRecive as List;

                print("detail screen result");

                print("${recordsRecive}");
                print("done");
                setState(() {

                });
              },
              icon: Icon(Icons.refresh))
        ],
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // Align to the bottom
          children: [
            Expanded(
              child: ListView.builder(itemCount: recordsReciveSave.length,itemBuilder: ((context, index) =>ListTile(
                title: Text("${recordsReciveSave[index]["id"]} - ${recordsReciveSave[index]["name_of_CMW"]}"),
              ) )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 120,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text('Add New', style: TextStyle(color: Colors.white)),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
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
