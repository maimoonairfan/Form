// databaseHelper.dart

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String dbName = 'user_profile.db';
  static const String tableName = 'user_data';

  Future<Database> initializeDatabase() async {
    final String path = join(await getDatabasesPath(), dbName);
    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name_of_CMW TEXT,
        nearest_Health_Facility TEXT,
        nearest_LHVs_Contact_Number TEXT,
        health_Center_Code TEXT,
        name_of_LHW TEXT,
        tehsil TEXT,
        village TEXT,
        PNC_Registration_Number TEXT,
        village_Population TEXT,
        catchment_Population TEXT,
        longest_distance_from_CMW TEXT,
        no_of_LHW_in_Catchment_Population TEXT,
        total_Population_of_LHW TEXT,
        total_traditional_birth_attendants_in_the_area_of_CMW TEXT,
        emergency_transport_phone_number_of_the_area TEXT,
        total_health_Facilities_available_for_the_referral_in_the_area TEXT,
        total_hospitals_available_for_the_referral_in_the_area TEXT
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    final Database db = await initializeDatabase();
    return await db.query(tableName);
  }

  Future<void> insertData(String label, String value) async {
    final Database db = await initializeDatabase();

    // Replace spaces with underscores in the label
    final String columnName = label.toLowerCase().replaceAll(' ', '_');

    await db.insert(
      tableName,
      {columnName: value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
