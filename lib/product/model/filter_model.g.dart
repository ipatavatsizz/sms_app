// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFilterModelCollection on Isar {
  IsarCollection<FilterModel> get filters => this.collection();
}

const FilterModelSchema = CollectionSchema(
  name: r'FilterModel',
  id: -6146017880781450933,
  properties: {
    r'active': PropertySchema(
      id: 0,
      name: r'active',
      type: IsarType.bool,
    ),
    r'filter': PropertySchema(
      id: 1,
      name: r'filter',
      type: IsarType.string,
    )
  },
  estimateSize: _filterModelEstimateSize,
  serialize: _filterModelSerialize,
  deserialize: _filterModelDeserialize,
  deserializeProp: _filterModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _filterModelGetId,
  getLinks: _filterModelGetLinks,
  attach: _filterModelAttach,
  version: '3.1.0+1',
);

int _filterModelEstimateSize(
  FilterModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.filter.length * 3;
  return bytesCount;
}

void _filterModelSerialize(
  FilterModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.active);
  writer.writeString(offsets[1], object.filter);
}

FilterModel _filterModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FilterModel(
    active: reader.readBoolOrNull(offsets[0]) ?? true,
    filter: reader.readString(offsets[1]),
    id: id,
  );
  return object;
}

P _filterModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _filterModelGetId(FilterModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _filterModelGetLinks(FilterModel object) {
  return [];
}

void _filterModelAttach(
    IsarCollection<dynamic> col, Id id, FilterModel object) {}

extension FilterModelQueryWhereSort
    on QueryBuilder<FilterModel, FilterModel, QWhere> {
  QueryBuilder<FilterModel, FilterModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FilterModelQueryWhere
    on QueryBuilder<FilterModel, FilterModel, QWhereClause> {
  QueryBuilder<FilterModel, FilterModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FilterModelQueryFilter
    on QueryBuilder<FilterModel, FilterModel, QFilterCondition> {
  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition> activeEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'active',
        value: value,
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition> filterEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'filter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition>
      filterGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'filter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition> filterLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'filter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition> filterBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'filter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition>
      filterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'filter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition> filterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'filter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition> filterContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'filter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition> filterMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'filter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition>
      filterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'filter',
        value: '',
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition>
      filterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'filter',
        value: '',
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FilterModelQueryObject
    on QueryBuilder<FilterModel, FilterModel, QFilterCondition> {}

extension FilterModelQueryLinks
    on QueryBuilder<FilterModel, FilterModel, QFilterCondition> {}

extension FilterModelQuerySortBy
    on QueryBuilder<FilterModel, FilterModel, QSortBy> {
  QueryBuilder<FilterModel, FilterModel, QAfterSortBy> sortByActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'active', Sort.asc);
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterSortBy> sortByActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'active', Sort.desc);
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterSortBy> sortByFilter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filter', Sort.asc);
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterSortBy> sortByFilterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filter', Sort.desc);
    });
  }
}

extension FilterModelQuerySortThenBy
    on QueryBuilder<FilterModel, FilterModel, QSortThenBy> {
  QueryBuilder<FilterModel, FilterModel, QAfterSortBy> thenByActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'active', Sort.asc);
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterSortBy> thenByActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'active', Sort.desc);
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterSortBy> thenByFilter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filter', Sort.asc);
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterSortBy> thenByFilterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'filter', Sort.desc);
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FilterModel, FilterModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension FilterModelQueryWhereDistinct
    on QueryBuilder<FilterModel, FilterModel, QDistinct> {
  QueryBuilder<FilterModel, FilterModel, QDistinct> distinctByActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'active');
    });
  }

  QueryBuilder<FilterModel, FilterModel, QDistinct> distinctByFilter(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'filter', caseSensitive: caseSensitive);
    });
  }
}

extension FilterModelQueryProperty
    on QueryBuilder<FilterModel, FilterModel, QQueryProperty> {
  QueryBuilder<FilterModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FilterModel, bool, QQueryOperations> activeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'active');
    });
  }

  QueryBuilder<FilterModel, String, QQueryOperations> filterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'filter');
    });
  }
}
