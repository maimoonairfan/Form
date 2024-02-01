import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String dbName = 'user_profile.db';
  static const String tableName = 'user_data';

  Future<Database> initializeDatabase() async {
    final String path = join(await getDatabasesPath(), dbName);
    print("data base init done sk");

    try {
      return openDatabase(path, version: 1, onCreate: _createDb);
    } catch (e) {
      print("e sk " + e.toString());
    }
    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    print("ct sk");
    await db.execute('''
  CREATE TABLE $tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name_of_CMW TEXT,
    nearest_Health_Facility TEXT,
    nearest_LHVs_Contact_Number TEXT,
    health_Center_Code TEXT,
    name_of_LHW TEXT,
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
    total_hospitals_available_for_the_referral_in_the_area TEXT,
    district,
    tehsil
    
  )
''');
    print("dt sk");
  }

  Future<void> insertData(
      String value1,
      String value2,
      String value3,
      String value4,
      String value5,
      String value6,
      String value7,
      String value8,
      String value9,
      String value10,
      String value11,
      String value12,
      String value13,
      String value14,
      String value15,
      String value16,
      String value17,
      String value18) async {
    final Database db = await initializeDatabase();

    final String sqlStatement =
        'INSERT INTO $tableName(name_of_CMW ,nearest_Health_Facility ,nearest_LHVs_Contact_Number ,health_Center_Code ,name_of_LHW ,village ,PNC_Registration_Number ,village_Population ,catchment_Population ,longest_distance_from_CMW ,no_of_LHW_in_Catchment_Population,total_Population_of_LHW,total_traditional_birth_attendants_in_the_area_of_CMW ,emergency_transport_phone_number_of_the_area ,total_health_Facilities_available_for_the_referral_in_the_area ,total_hospitals_available_for_the_referral_in_the_area,district,tehsil ) VALUES("$value1","$value2","$value3","$value4","$value5","$value6","$value7","$value8","$value9","$value10","$value11","$value12","$value13","$value14","$value15","$value16","$value17","$value18")';
    print('Executing SQL statement: $sqlStatement');

    await db.rawInsert(sqlStatement);

    print("data added inserted");
  }

  Future selectData() async {
    final Database db = await initializeDatabase();
    final String selectStatement = ('SELECT * FROM $tableName');
    var recodrs = await db.rawQuery(selectStatement);
    print('All data Selected');
    print("${recodrs}");
    print('done');
    return recodrs;
  }
}
