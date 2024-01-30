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

  // Variables for text fields
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
              buildDropdownFormField(
                  'District', selectedDropdown1, dropdownOptions),
              buildDropdownFormField(
                  'Tehsil', selectedDropdown2, dropdownOptionstehsil),

              SizedBox(
                height: 50.0,
                width: 200.0,
                child: TextButton(
                  onPressed: () async {
                    // Save form data to the database
                    saveFormData();

                    // Navigate to the next screen to display the information
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Details()),
                    );
                  },
                  child: TextButton(
                      onPressed: () {
                        print(DatabaseHelper.tableName);
                      },
                      child: Text('Submit',
                          style: TextStyle(color: Colors.white))),
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

  Widget buildDropdownFormField(
      String label, String value, List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12,
      ),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: value,
            onChanged: (newValue) {
              setState(() {
                value = newValue!;
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

  void saveFormData() async {
    // Save form data to the database
    await dbHelper.insertData('name_of_CMW', nameCMWController.text);
    await dbHelper.insertData(
        'nearest_Health_Facility', nearestHealthFacilityController.text);
    await dbHelper.insertData(
        'nearest_LHVs_Contact_Number', nearestLHVsContactNumberController.text);
    await dbHelper.insertData(
        'health_Center_Code', healthCenterCodeController.text);
    await dbHelper.insertData('name_of_LHW', nameLHWController.text);
    await dbHelper.insertData('village', villageController.text);
    await dbHelper.insertData(
        'PNC_Registration_Number', pncRegistrationNumberController.text);
    await dbHelper.insertData(
        'village_Population', villagePopulationController.text);
    await dbHelper.insertData(
        'catchment_Population', catchmentPopulationController.text);
    await dbHelper.insertData(
        'longest_distance_from_CMW', longestDistanceCMWController.text);
    await dbHelper.insertData('no_of_LHW_in_Catchment_Population',
        noLHWInCatchmentPopulationController.text);
    await dbHelper.insertData(
        'total_Population_of_LHW', totalPopulationLHWController.text);
    await dbHelper.insertData(
        'total_traditional_birth_attendants_in_the_area_of_CMW',
        totalTraditionalBirthAttendantsController.text);
    await dbHelper.insertData('emergency_transport_phone_number_of_the_area',
        emergencyTransportPhoneNumberController.text);
    await dbHelper.insertData(
        'total_health_Facilities_available_for_the_referral_in_the_area',
        totalHealthFacilitiesController.text);
    await dbHelper.insertData(
        'total_hospitals_available_for_the_referral_in_the_area',
        totalHospitalsController.text);
    await dbHelper.insertData('district', selectedDropdown1);
    await dbHelper.insertData('tehsil', selectedDropdown2);
  }
}
