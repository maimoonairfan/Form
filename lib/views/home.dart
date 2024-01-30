// homePage.dart

import 'package:application/db/databaseHelper.dart';
import 'package:application/views/details.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  List<String> labels = [
    'Name of CMW',
    'Nearest Health Facility',
    'Nearest LHVs Contact Number',
    'Health Center Code',
    'Name of LHW',
    'Village',
    'PNC Registration Number',
    'Village Population',
    'Catchment Population',
    'Longest distance from CMW',
    'No of LHW in Catchment Population',
    'Total Population of LHW',
    'Total traditional birth attendants in the area of CMW',
    'Emergency transport phone number of the area',
    'Total health Facilities available for the referral in the area',
    'Total hospitals available for the referral in the area',
  ];

  String selectedDropdown1 = 'Astore';
  String selectedDropdown2 = 'Astore';

  List<String> dropdownOptions = [
    'Astore',
    'Diamer',
    'Ghanche',
    'Ghizer',
    'Gilgit',
    'Kharmong',
    'Nagar',
    'Shigar',
    'Skardu'
  ];
  List<String> dropdownOptionstehsil = [
    'Astore',
    'Shounter',
    'Chilas',
    'Dhagoni',
    'Khalpu',
    'Yasin',
    'Punial',
    'Gupis',
    'Ghizer',
    'Ishkomin',
    'Pahander',
    'Danyore',
    'Nomal',
    'Jeglote',
    'Gojal',
    'Gilgit',
    'Kharmong',
    'Nagar',
    'Shigar',
    'Skardu',
    'Sikander',
    'Gamba',
    'Roundu'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile',
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (String label in labels)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12,
                  ),
                  child: label.contains("Name of LHW")
                      ? Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: label,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 5,
                                    color: Colors.black26,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: selectedDropdown1,
                              onChanged: (value) {
                                setState(() {
                                  selectedDropdown1 = value!;
                                });
                              },
                              items: dropdownOptions
                                  .map<DropdownMenuItem<String>>(
                                    (String value) =>
                                        DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                              decoration: InputDecoration(
                                labelText: 'District',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 5,
                                    color: Colors.black26,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: selectedDropdown2,
                              onChanged: (value) {
                                setState(() {
                                  selectedDropdown2 = value!;
                                });
                              },
                              items: dropdownOptionstehsil
                                  .map<DropdownMenuItem<String>>(
                                    (String value) =>
                                        DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                              decoration: InputDecoration(
                                labelText: 'Tehsil',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 5,
                                    color: Colors.black26,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                            ),
                          ],
                        )
                      : TextFormField(
                          decoration: InputDecoration(
                            labelText: label,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 5,
                                color: Colors.black26,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                ),
              SizedBox(
                height: 50.0,
                width: 200.0,
                child: TextButton(
                  onPressed: () async {
                    // Save form data to the database
                    for (int i = 0; i < labels.length; i++) {
                      String value;
                      if (labels[i].contains("Name of LHW")) {
                        value = (i == labels.indexOf("Name of LHW"))
                            ? selectedDropdown1
                            : '';
                      } else {
                        // Replace with the actual value from TextFormField
                        // For now, let's assume the TextFormField value is an empty string
                        value = '';
                      }

                      print('Inserting: Label: ${labels[i]}, Value: $value');

                      try {
                        await dbHelper.insertData(labels[i], value);
                        print('Insert successful');
                      } catch (e) {
                        print('Insert failed: $e');
                      }
                    }

                    // Navigate to the next screen to display the information
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Details()),
                    );
                  },
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
