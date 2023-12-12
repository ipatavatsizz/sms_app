class FilterModel {
  final String name;
  final String filter;
  final bool active;

  FilterModel copyWith({
    String? name,
    String? filter,
    bool? active,
  }) =>
      FilterModel(
        name: name ?? this.name,
        filter: filter ?? this.filter,
        active: active ?? this.active,
      );

  FilterModel({required this.name, required this.filter, this.active = true});
}
