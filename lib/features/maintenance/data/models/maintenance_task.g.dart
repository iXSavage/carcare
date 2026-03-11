// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_task.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMaintenanceTaskCollection on Isar {
  IsarCollection<MaintenanceTask> get maintenanceTasks => this.collection();
}

const MaintenanceTaskSchema = CollectionSchema(
  name: r'MaintenanceTask',
  id: 8061396590624687110,
  properties: {
    r'carId': PropertySchema(
      id: 0,
      name: r'carId',
      type: IsarType.long,
    ),
    r'isCompleted': PropertySchema(
      id: 1,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'lastServiceDate': PropertySchema(
      id: 2,
      name: r'lastServiceDate',
      type: IsarType.dateTime,
    ),
    r'lastServiceMileage': PropertySchema(
      id: 3,
      name: r'lastServiceMileage',
      type: IsarType.long,
    ),
    r'mileageInterval': PropertySchema(
      id: 4,
      name: r'mileageInterval',
      type: IsarType.long,
    ),
    r'nextDueDate': PropertySchema(
      id: 5,
      name: r'nextDueDate',
      type: IsarType.dateTime,
    ),
    r'nextDueMileage': PropertySchema(
      id: 6,
      name: r'nextDueMileage',
      type: IsarType.long,
    ),
    r'notes': PropertySchema(
      id: 7,
      name: r'notes',
      type: IsarType.string,
    ),
    r'taskName': PropertySchema(
      id: 8,
      name: r'taskName',
      type: IsarType.string,
    ),
    r'timeIntervalMonths': PropertySchema(
      id: 9,
      name: r'timeIntervalMonths',
      type: IsarType.long,
    )
  },
  estimateSize: _maintenanceTaskEstimateSize,
  serialize: _maintenanceTaskSerialize,
  deserialize: _maintenanceTaskDeserialize,
  deserializeProp: _maintenanceTaskDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _maintenanceTaskGetId,
  getLinks: _maintenanceTaskGetLinks,
  attach: _maintenanceTaskAttach,
  version: '3.1.0+1',
);

int _maintenanceTaskEstimateSize(
  MaintenanceTask object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.taskName.length * 3;
  return bytesCount;
}

void _maintenanceTaskSerialize(
  MaintenanceTask object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.carId);
  writer.writeBool(offsets[1], object.isCompleted);
  writer.writeDateTime(offsets[2], object.lastServiceDate);
  writer.writeLong(offsets[3], object.lastServiceMileage);
  writer.writeLong(offsets[4], object.mileageInterval);
  writer.writeDateTime(offsets[5], object.nextDueDate);
  writer.writeLong(offsets[6], object.nextDueMileage);
  writer.writeString(offsets[7], object.notes);
  writer.writeString(offsets[8], object.taskName);
  writer.writeLong(offsets[9], object.timeIntervalMonths);
}

MaintenanceTask _maintenanceTaskDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MaintenanceTask();
  object.carId = reader.readLong(offsets[0]);
  object.id = id;
  object.isCompleted = reader.readBool(offsets[1]);
  object.lastServiceDate = reader.readDateTimeOrNull(offsets[2]);
  object.lastServiceMileage = reader.readLongOrNull(offsets[3]);
  object.mileageInterval = reader.readLongOrNull(offsets[4]);
  object.nextDueDate = reader.readDateTimeOrNull(offsets[5]);
  object.nextDueMileage = reader.readLongOrNull(offsets[6]);
  object.notes = reader.readStringOrNull(offsets[7]);
  object.taskName = reader.readString(offsets[8]);
  object.timeIntervalMonths = reader.readLongOrNull(offsets[9]);
  return object;
}

P _maintenanceTaskDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _maintenanceTaskGetId(MaintenanceTask object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _maintenanceTaskGetLinks(MaintenanceTask object) {
  return [];
}

void _maintenanceTaskAttach(
    IsarCollection<dynamic> col, Id id, MaintenanceTask object) {
  object.id = id;
}

extension MaintenanceTaskQueryWhereSort
    on QueryBuilder<MaintenanceTask, MaintenanceTask, QWhere> {
  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MaintenanceTaskQueryWhere
    on QueryBuilder<MaintenanceTask, MaintenanceTask, QWhereClause> {
  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterWhereClause> idBetween(
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

extension MaintenanceTaskQueryFilter
    on QueryBuilder<MaintenanceTask, MaintenanceTask, QFilterCondition> {
  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      carIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carId',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      carIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carId',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      carIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carId',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      carIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      lastServiceDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastServiceDate',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      lastServiceDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastServiceDate',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      lastServiceDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastServiceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      lastServiceDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastServiceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      lastServiceDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastServiceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      lastServiceDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastServiceDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      lastServiceMileageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastServiceMileage',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      lastServiceMileageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastServiceMileage',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      lastServiceMileageEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastServiceMileage',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      lastServiceMileageGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastServiceMileage',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      lastServiceMileageLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastServiceMileage',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      lastServiceMileageBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastServiceMileage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      mileageIntervalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mileageInterval',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      mileageIntervalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mileageInterval',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      mileageIntervalEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mileageInterval',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      mileageIntervalGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mileageInterval',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      mileageIntervalLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mileageInterval',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      mileageIntervalBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mileageInterval',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      nextDueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextDueDate',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      nextDueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextDueDate',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      nextDueDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      nextDueDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      nextDueDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      nextDueDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextDueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      nextDueMileageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextDueMileage',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      nextDueMileageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextDueMileage',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      nextDueMileageEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextDueMileage',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      nextDueMileageGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextDueMileage',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      nextDueMileageLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextDueMileage',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      nextDueMileageBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextDueMileage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      taskNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      taskNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taskName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      taskNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taskName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      taskNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taskName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      taskNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'taskName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      taskNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'taskName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      taskNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'taskName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      taskNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'taskName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      taskNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskName',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      taskNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'taskName',
        value: '',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      timeIntervalMonthsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timeIntervalMonths',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      timeIntervalMonthsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timeIntervalMonths',
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      timeIntervalMonthsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeIntervalMonths',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      timeIntervalMonthsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeIntervalMonths',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      timeIntervalMonthsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeIntervalMonths',
        value: value,
      ));
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterFilterCondition>
      timeIntervalMonthsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeIntervalMonths',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MaintenanceTaskQueryObject
    on QueryBuilder<MaintenanceTask, MaintenanceTask, QFilterCondition> {}

extension MaintenanceTaskQueryLinks
    on QueryBuilder<MaintenanceTask, MaintenanceTask, QFilterCondition> {}

extension MaintenanceTaskQuerySortBy
    on QueryBuilder<MaintenanceTask, MaintenanceTask, QSortBy> {
  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy> sortByCarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByCarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByLastServiceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastServiceDate', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByLastServiceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastServiceDate', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByLastServiceMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastServiceMileage', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByLastServiceMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastServiceMileage', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByMileageInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileageInterval', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByMileageIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileageInterval', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByNextDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueDate', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByNextDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueDate', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByNextDueMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueMileage', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByNextDueMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueMileage', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByTaskName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskName', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByTaskNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskName', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByTimeIntervalMonths() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeIntervalMonths', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      sortByTimeIntervalMonthsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeIntervalMonths', Sort.desc);
    });
  }
}

extension MaintenanceTaskQuerySortThenBy
    on QueryBuilder<MaintenanceTask, MaintenanceTask, QSortThenBy> {
  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy> thenByCarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByCarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByLastServiceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastServiceDate', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByLastServiceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastServiceDate', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByLastServiceMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastServiceMileage', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByLastServiceMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastServiceMileage', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByMileageInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileageInterval', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByMileageIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mileageInterval', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByNextDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueDate', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByNextDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueDate', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByNextDueMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueMileage', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByNextDueMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueMileage', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByTaskName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskName', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByTaskNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskName', Sort.desc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByTimeIntervalMonths() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeIntervalMonths', Sort.asc);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QAfterSortBy>
      thenByTimeIntervalMonthsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeIntervalMonths', Sort.desc);
    });
  }
}

extension MaintenanceTaskQueryWhereDistinct
    on QueryBuilder<MaintenanceTask, MaintenanceTask, QDistinct> {
  QueryBuilder<MaintenanceTask, MaintenanceTask, QDistinct> distinctByCarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carId');
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QDistinct>
      distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QDistinct>
      distinctByLastServiceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastServiceDate');
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QDistinct>
      distinctByLastServiceMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastServiceMileage');
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QDistinct>
      distinctByMileageInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mileageInterval');
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QDistinct>
      distinctByNextDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextDueDate');
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QDistinct>
      distinctByNextDueMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextDueMileage');
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QDistinct> distinctByTaskName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaintenanceTask, MaintenanceTask, QDistinct>
      distinctByTimeIntervalMonths() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeIntervalMonths');
    });
  }
}

extension MaintenanceTaskQueryProperty
    on QueryBuilder<MaintenanceTask, MaintenanceTask, QQueryProperty> {
  QueryBuilder<MaintenanceTask, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MaintenanceTask, int, QQueryOperations> carIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carId');
    });
  }

  QueryBuilder<MaintenanceTask, bool, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<MaintenanceTask, DateTime?, QQueryOperations>
      lastServiceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastServiceDate');
    });
  }

  QueryBuilder<MaintenanceTask, int?, QQueryOperations>
      lastServiceMileageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastServiceMileage');
    });
  }

  QueryBuilder<MaintenanceTask, int?, QQueryOperations>
      mileageIntervalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mileageInterval');
    });
  }

  QueryBuilder<MaintenanceTask, DateTime?, QQueryOperations>
      nextDueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextDueDate');
    });
  }

  QueryBuilder<MaintenanceTask, int?, QQueryOperations>
      nextDueMileageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextDueMileage');
    });
  }

  QueryBuilder<MaintenanceTask, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<MaintenanceTask, String, QQueryOperations> taskNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskName');
    });
  }

  QueryBuilder<MaintenanceTask, int?, QQueryOperations>
      timeIntervalMonthsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeIntervalMonths');
    });
  }
}
