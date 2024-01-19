import 'package:isar/isar.dart';

part 'filter_model.g.dart';

@Collection(accessor: 'filters')
class FilterModel {
  final Id id;
  final String filter;
  final bool active;

  FilterModel copyWith({
    String? filter,
    Id? id,
    bool? active,
  }) =>
      FilterModel(
        filter: filter ?? this.filter,
        id: id ?? this.id,
        active: active ?? this.active,
      );

  FilterModel({
    required this.filter,
    this.id = Isar.autoIncrement,
    this.active = true,
  });
}
