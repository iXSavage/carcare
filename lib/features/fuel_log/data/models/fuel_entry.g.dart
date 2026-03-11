// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFuelEntryCollection on Isar {
  IsarCollection<FuelEntry> get fuelEntrys => this.collection();
}

const FuelEntrySchema = CollectionSchema(
  name: r'FuelEntry',
  id: -415304569610854362,
  properties: {
    r'carId': PropertySchema(
      id: 0,
      name: r'carId',
      type: IsarType.long,
    ),
    r'costPerLitre': PropertySchema(
      id: 1,
      name: r'costPerLitre',
      type: IsarType.double,
    ),
    r'costTotal': PropertySchema(
      id: 2,
      name: r'costTotal',
      type: IsarType.double,
    ),
    r'date': PropertySchema(
      id: 3,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'isFull': PropertySchema(
      id: 4,
      name: r'isFull',
      type: IsarType.bool,
    ),
    r'litres': PropertySchema(
      id: 5,
      name: r'litres',
      type: IsarType.double,
    ),
    r'litresPer100km': PropertySchema(
      id: 6,
      name: r'litresPer100km',
      type: IsarType.double,
    ),
    r'milesPerGallon': PropertySchema(
      id: 7,
      name: r'milesPerGallon',
      type: IsarType.double,
    ),
    r'notes': PropertySchema(
      id: 8,
      name: r'notes',
      type: IsarType.string,
    ),
    r'odometer': PropertySchema(
      id: 9,
      name: r'odometer',
      type: IsarType.long,
    ),
    r'receiptPhotoPath': PropertySchema(
      id: 10,
      name: r'receiptPhotoPath',
      type: IsarType.string,
    )
  },
  estimateSize: _fuelEntryEstimateSize,
  serialize: _fuelEntrySerialize,
  deserialize: _fuelEntryDeserialize,
  deserializeProp: _fuelEntryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _fuelEntryGetId,
  getLinks: _fuelEntryGetLinks,
  attach: _fuelEntryAttach,
  version: '3.1.0+1',
);

int _fuelEntryEstimateSize(
  FuelEntry object,
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
  {
    final value = object.receiptPhotoPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _fuelEntrySerialize(
  FuelEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.carId);
  writer.writeDouble(offsets[1], object.costPerLitre);
  writer.writeDouble(offsets[2], object.costTotal);
  writer.writeDateTime(offsets[3], object.date);
  writer.writeBool(offsets[4], object.isFull);
  writer.writeDouble(offsets[5], object.litres);
  writer.writeDouble(offsets[6], object.litresPer100km);
  writer.writeDouble(offsets[7], object.milesPerGallon);
  writer.writeString(offsets[8], object.notes);
  writer.writeLong(offsets[9], object.odometer);
  writer.writeString(offsets[10], object.receiptPhotoPath);
}

FuelEntry _fuelEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FuelEntry();
  object.carId = reader.readLong(offsets[0]);
  object.costPerLitre = reader.readDoubleOrNull(offsets[1]);
  object.costTotal = reader.readDouble(offsets[2]);
  object.date = reader.readDateTime(offsets[3]);
  object.id = id;
  object.isFull = reader.readBool(offsets[4]);
  object.litres = reader.readDouble(offsets[5]);
  object.litresPer100km = reader.readDoubleOrNull(offsets[6]);
  object.milesPerGallon = reader.readDoubleOrNull(offsets[7]);
  object.notes = reader.readStringOrNull(offsets[8]);
  object.odometer = reader.readLong(offsets[9]);
  object.receiptPhotoPath = reader.readStringOrNull(offsets[10]);
  return object;
}

P _fuelEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _fuelEntryGetId(FuelEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _fuelEntryGetLinks(FuelEntry object) {
  return [];
}

void _fuelEntryAttach(IsarCollection<dynamic> col, Id id, FuelEntry object) {
  object.id = id;
}

extension FuelEntryQueryWhereSort
    on QueryBuilder<FuelEntry, FuelEntry, QWhere> {
  QueryBuilder<FuelEntry, FuelEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FuelEntryQueryWhere
    on QueryBuilder<FuelEntry, FuelEntry, QWhereClause> {
  QueryBuilder<FuelEntry, FuelEntry, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<FuelEntry, FuelEntry, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterWhereClause> idBetween(
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

extension FuelEntryQueryFilter
    on QueryBuilder<FuelEntry, FuelEntry, QFilterCondition> {
  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> carIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carId',
        value: value,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> carIdGreaterThan(
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

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> carIdLessThan(
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

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> carIdBetween(
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

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      costPerLitreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'costPerLitre',
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      costPerLitreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'costPerLitre',
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> costPerLitreEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'costPerLitre',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      costPerLitreGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'costPerLitre',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      costPerLitreLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'costPerLitre',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> costPerLitreBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'costPerLitre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> costTotalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'costTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      costTotalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'costTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> costTotalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'costTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> costTotalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'costTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> isFullEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFull',
        value: value,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> litresEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'litres',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> litresGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'litres',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> litresLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'litres',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> litresBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'litres',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      litresPer100kmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'litresPer100km',
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      litresPer100kmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'litresPer100km',
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      litresPer100kmEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'litresPer100km',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      litresPer100kmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'litresPer100km',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      litresPer100kmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'litresPer100km',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      litresPer100kmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'litresPer100km',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      milesPerGallonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'milesPerGallon',
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      milesPerGallonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'milesPerGallon',
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      milesPerGallonEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'milesPerGallon',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      milesPerGallonGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'milesPerGallon',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      milesPerGallonLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'milesPerGallon',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      milesPerGallonBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'milesPerGallon',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesEqualTo(
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

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesGreaterThan(
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

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesLessThan(
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

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesBetween(
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

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesStartsWith(
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

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesEndsWith(
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

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> odometerEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'odometer',
        value: value,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> odometerGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'odometer',
        value: value,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> odometerLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'odometer',
        value: value,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition> odometerBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'odometer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      receiptPhotoPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'receiptPhotoPath',
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      receiptPhotoPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'receiptPhotoPath',
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      receiptPhotoPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receiptPhotoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      receiptPhotoPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'receiptPhotoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      receiptPhotoPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'receiptPhotoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      receiptPhotoPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'receiptPhotoPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      receiptPhotoPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'receiptPhotoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      receiptPhotoPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'receiptPhotoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      receiptPhotoPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'receiptPhotoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      receiptPhotoPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'receiptPhotoPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      receiptPhotoPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receiptPhotoPath',
        value: '',
      ));
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterFilterCondition>
      receiptPhotoPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'receiptPhotoPath',
        value: '',
      ));
    });
  }
}

extension FuelEntryQueryObject
    on QueryBuilder<FuelEntry, FuelEntry, QFilterCondition> {}

extension FuelEntryQueryLinks
    on QueryBuilder<FuelEntry, FuelEntry, QFilterCondition> {}

extension FuelEntryQuerySortBy on QueryBuilder<FuelEntry, FuelEntry, QSortBy> {
  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByCarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByCarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByCostPerLitre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costPerLitre', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByCostPerLitreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costPerLitre', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByCostTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costTotal', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByCostTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costTotal', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByIsFull() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFull', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByIsFullDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFull', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByLitres() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'litres', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByLitresDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'litres', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByLitresPer100km() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'litresPer100km', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByLitresPer100kmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'litresPer100km', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByMilesPerGallon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milesPerGallon', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByMilesPerGallonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milesPerGallon', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByOdometer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'odometer', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByOdometerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'odometer', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> sortByReceiptPhotoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiptPhotoPath', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy>
      sortByReceiptPhotoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiptPhotoPath', Sort.desc);
    });
  }
}

extension FuelEntryQuerySortThenBy
    on QueryBuilder<FuelEntry, FuelEntry, QSortThenBy> {
  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByCarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByCarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByCostPerLitre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costPerLitre', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByCostPerLitreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costPerLitre', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByCostTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costTotal', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByCostTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costTotal', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByIsFull() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFull', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByIsFullDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFull', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByLitres() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'litres', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByLitresDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'litres', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByLitresPer100km() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'litresPer100km', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByLitresPer100kmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'litresPer100km', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByMilesPerGallon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milesPerGallon', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByMilesPerGallonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'milesPerGallon', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByOdometer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'odometer', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByOdometerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'odometer', Sort.desc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy> thenByReceiptPhotoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiptPhotoPath', Sort.asc);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QAfterSortBy>
      thenByReceiptPhotoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiptPhotoPath', Sort.desc);
    });
  }
}

extension FuelEntryQueryWhereDistinct
    on QueryBuilder<FuelEntry, FuelEntry, QDistinct> {
  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByCarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carId');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByCostPerLitre() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'costPerLitre');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByCostTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'costTotal');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByIsFull() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFull');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByLitres() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'litres');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByLitresPer100km() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'litresPer100km');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByMilesPerGallon() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'milesPerGallon');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByOdometer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'odometer');
    });
  }

  QueryBuilder<FuelEntry, FuelEntry, QDistinct> distinctByReceiptPhotoPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'receiptPhotoPath',
          caseSensitive: caseSensitive);
    });
  }
}

extension FuelEntryQueryProperty
    on QueryBuilder<FuelEntry, FuelEntry, QQueryProperty> {
  QueryBuilder<FuelEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FuelEntry, int, QQueryOperations> carIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carId');
    });
  }

  QueryBuilder<FuelEntry, double?, QQueryOperations> costPerLitreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'costPerLitre');
    });
  }

  QueryBuilder<FuelEntry, double, QQueryOperations> costTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'costTotal');
    });
  }

  QueryBuilder<FuelEntry, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<FuelEntry, bool, QQueryOperations> isFullProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFull');
    });
  }

  QueryBuilder<FuelEntry, double, QQueryOperations> litresProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'litres');
    });
  }

  QueryBuilder<FuelEntry, double?, QQueryOperations> litresPer100kmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'litresPer100km');
    });
  }

  QueryBuilder<FuelEntry, double?, QQueryOperations> milesPerGallonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'milesPerGallon');
    });
  }

  QueryBuilder<FuelEntry, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<FuelEntry, int, QQueryOperations> odometerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'odometer');
    });
  }

  QueryBuilder<FuelEntry, String?, QQueryOperations>
      receiptPhotoPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'receiptPhotoPath');
    });
  }
}
