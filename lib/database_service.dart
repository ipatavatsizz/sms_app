import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sms_app/model/filter_model.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService();

  Box<String>? settings;
  Box<FilterModel>? filter;

  static Future<void> ensureInitialized() async {
    final directory = await getApplicationCacheDirectory();

    Hive.init(directory.path);

    instance.filter = await Hive.openBox<FilterModel>('filter');
    instance.settings = await Hive.openBox<String>('settings');
  }
}
