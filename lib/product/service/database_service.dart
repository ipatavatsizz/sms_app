import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sms_app/product/model/filter_model.dart';

@pragma('vm:entry-point')
class DatabaseService {
  static final DatabaseService instance = DatabaseService();

  Isar? service;

  static Future<void> initialize(List<CollectionSchema> schemas) async {
    final directory = await getApplicationCacheDirectory();

    await Isar.initializeIsarCore(download: true);
    instance.service = await Isar.open(schemas, directory: directory.path);
  }

  Future<void> put(FilterModel model) async {
    await service!.writeTxn(() async => service!.filters.put(model));
  }

  Future<FilterModel?> get(int id) async {
    return await service!.txn(() async => service!.filters.get(id));
  }

  Future<List<FilterModel>> getAll() async {
    return await service!
        .txn(() async => await service!.filters.where().findAll());
  }

  Future<void> delete(int id) async {
    service!.writeTxn(() async => service!.filters.delete(id));
  }
}
