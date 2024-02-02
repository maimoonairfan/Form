import 'dart:convert';

import 'package:application/db/databaseHelper.dart';
import 'package:application/views/details.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String sendData;
  final bool isSend;
  const HomePage({Key? key, this.sendData = "", this.isSend = false})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  TextEditingController nameCMWController = TextEditingController();
  TextEditingController nearestHealthFacilityController =
      TextEditingController();
  TextEditingController nearestLHVsContactNumberController =
      TextEditingController();
  TextEditingController healthCenterCodeController = TextEditingController();
  TextEditingController nameLHWController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController pncRegistrationNumberController =
      TextEditingController();
  TextEditingController villagePopulationController = TextEditingController();
  TextEditingController catchmentPopulationController = TextEditingController();
  TextEditingController longestDistanceCMWController = TextEditingController();
  TextEditingController noLHWInCatchmentPopulationController =
      TextEditingController();
  TextEditingController totalPopulationLHWController = TextEditingController();
  TextEditingController totalTraditionalBirthAttendantsController =
      TextEditingController();
  TextEditingController emergencyTransportPhoneNumberController =
      TextEditingController();
  TextEditingController totalHealthFacilitiesController =
      TextEditingController();
  TextEditingController totalHospitalsController = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();
  TextEditingController tehsilController = TextEditingController();

  // Dropdown variables
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
  void initState() {
    super.initState();
    print("sd sk");
    dbHelper.initializeDatabase();
    print("cd sk");

    if (widget.isSend == true) {
      print("form data");

      print(widget.sendData);

      var formData = jsonDecode(widget.sendData);

      nameCMWController.text = formData["name_of_CMW"];

      print("done");
    }
  }

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
              // TextFormFields
              buildTextFormField('Name of CMW', nameCMWController),
              buildTextFormField(
                  'Nearest Health Facility', nearestHealthFacilityController),
              buildTextFormField('Nearest LHVs Contact Number',
                  nearestLHVsContactNumberController),
              buildTextFormField(
                  'Health Center Code', healthCenterCodeController),
              buildTextFormField('Name of LHW', nameLHWController),
              buildTextFormField('Village', villageController),
              buildTextFormField(
                  'PNC Registration Number', pncRegistrationNumberController),
              buildTextFormField(
                  'Village Population', villagePopulationController),
              buildTextFormField(
                  'Catchment Population', catchmentPopulationController),
              buildTextFormField(
                  'Longest distance from CMW', longestDistanceCMWController),
              buildTextFormField('No of LHW in Catchment Population',
                  noLHWInCatchmentPopulationController),
              buildTextFormField(
                  'Total Population of LHW', totalPopulationLHWController),
              buildTextFormField(
                  'Total traditional birth attendants in the area of CMW',
                  totalTraditionalBirthAttendantsController),
              buildTextFormField('Emergency transport phone number of the area',
                  emergencyTransportPhoneNumberController),
              buildTextFormField(
                  'Total health Facilities available for the referral in the area',
                  totalHealthFacilitiesController),
              buildTextFormField(
                  'Total hospitals available for the referral in the area',
                  totalHospitalsController),

              // Dropdowns
              // Dropdowns
              buildDropdownFormField('District', selectedDropdown1,
                  dropdownOptions, districtcontroller),
              buildDropdownFormField('Tehsil', selectedDropdown2,
                  dropdownOptionstehsil, tehsilController),

              SizedBox(
                height: 50.0,
                width: 200.0,
                child: TextButton(
                  onPressed: () async {
                    // Save form data to the database
                    dbHelper.insertData(
                        nameCMWController.text,
                        nearestHealthFacilityController.text,
                        nearestLHVsContactNumberController.text,
                        healthCenterCodeController.text,
                        nameLHWController.text,
                        villageController.text,
                        pncRegistrationNumberController.text,
                        villagePopulationController.text,
                        catchmentPopulationController.text,
                        longestDistanceCMWController.text,
                        catchmentPopulationController.text,
                        totalPopulationLHWController.text,
                        totalTraditionalBirthAttendantsController.text,
                        emergencyTransportPhoneNumberController.text,
                        totalHealthFacilitiesController.text,
                        totalHospitalsController.text,
                        districtcontroller.text,
                        tehsilController.text);

                    // Navigate to the next screen to display the information
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Details()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12,
      ),
      child: TextFormField(
        controller: controller,
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
    );
  }

  Widget buildDropdownFormField(String label, String selectedValue,
      List<String> options, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12,
      ),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: selectedValue,
            onChanged: (newValue) {
              // Update the dropdown value and the controller
              setState(() {
                selectedValue = newValue!;
                controller.text = newValue; // Update the controller
              });
            },
            items: options
                .map<DropdownMenuItem<String>>(
                  (String option) => DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  ),
                )
                .toList(),
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
        ],
      ),
    );
  }
}
