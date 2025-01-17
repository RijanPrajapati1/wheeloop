import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wheeloop/app/constants/hive_table_constant.dart';
import 'package:wheeloop/features/auth/data/model/auth_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}wheeloop.db';

    Hive.init(path);

    // Register Adapters

    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  // Auth Queries
  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.customerBox);
    await box.put(auth.customerId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.customerBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.customerBox);
    return box.values.toList();
  }

  // Login using email and password
  Future<AuthHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.customerBox);
    var customer = box.values.firstWhere(
        (element) => element.email == email && element.password == password);
    box.close();
    return customer;
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.customerBox);
  }

  // Clear Customer Box
  Future<void> clearCustomerBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.customerBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
