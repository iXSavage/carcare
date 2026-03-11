// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_reminder.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDocumentReminderCollection on Isar {
  IsarCollection<DocumentReminder> get documentReminders => this.collection();
}

const DocumentReminderSchema = CollectionSchema(
  name: r'DocumentReminder',
  id: 7669220862965919239,
  properties: {
    r'carId': PropertySchema(
      id: 0,
      name: r'carId',
      type: IsarType.long,
    ),
    r'documentTitle': PropertySchema(
      id: 1,
      name: r'documentTitle',
      type: IsarType.string,
    ),
    r'documentType': PropertySchema(
      id: 2,
      name: r'documentType',
      type: IsarType.string,
    ),
    r'expiryDate': PropertySchema(
      id: 3,
      name: r'expiryDate',
      type: IsarType.dateTime,
    ),
    r'isActive': PropertySchema(
      id: 4,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'issueDate': PropertySchema(
      id: 5,
      name: r'issueDate',
      type: IsarType.dateTime,
    ),
    r'issuingAuthority': PropertySchema(
      id: 6,
      name: r'issuingAuthority',
      type: IsarType.string,
    ),
    r'lastNotifiedOffset': PropertySchema(
      id: 7,
      name: r'lastNotifiedOffset',
      type: IsarType.long,
    ),
    r'notes': PropertySchema(
      id: 8,
      name: r'notes',
      type: IsarType.string,
    ),
    r'notificationIds': PropertySchema(
      id: 9,
      name: r'notificationIds',
      type: IsarType.longList,
    ),
    r'reminderOffsets': PropertySchema(
      id: 10,
      name: r'reminderOffsets',
      type: IsarType.longList,
    )
  },
  estimateSize: _documentReminderEstimateSize,
  serialize: _documentReminderSerialize,
  deserialize: _documentReminderDeserialize,
  deserializeProp: _documentReminderDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _documentReminderGetId,
  getLinks: _documentReminderGetLinks,
  attach: _documentReminderAttach,
  version: '3.1.0+1',
);

int _documentReminderEstimateSize(
  DocumentReminder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.documentTitle.length * 3;
  bytesCount += 3 + object.documentType.length * 3;
  {
    final value = object.issuingAuthority;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.notificationIds.length * 8;
  bytesCount += 3 + object.reminderOffsets.length * 8;
  return bytesCount;
}

void _documentReminderSerialize(
  DocumentReminder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.carId);
  writer.writeString(offsets[1], object.documentTitle);
  writer.writeString(offsets[2], object.documentType);
  writer.writeDateTime(offsets[3], object.expiryDate);
  writer.writeBool(offsets[4], object.isActive);
  writer.writeDateTime(offsets[5], object.issueDate);
  writer.writeString(offsets[6], object.issuingAuthority);
  writer.writeLong(offsets[7], object.lastNotifiedOffset);
  writer.writeString(offsets[8], object.notes);
  writer.writeLongList(offsets[9], object.notificationIds);
  writer.writeLongList(offsets[10], object.reminderOffsets);
}

DocumentReminder _documentReminderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DocumentReminder();
  object.carId = reader.readLong(offsets[0]);
  object.documentTitle = reader.readString(offsets[1]);
  object.documentType = reader.readString(offsets[2]);
  object.expiryDate = reader.readDateTime(offsets[3]);
  object.id = id;
  object.isActive = reader.readBool(offsets[4]);
  object.issueDate = reader.readDateTimeOrNull(offsets[5]);
  object.issuingAuthority = reader.readStringOrNull(offsets[6]);
  object.lastNotifiedOffset = reader.readLongOrNull(offsets[7]);
  object.notes = reader.readStringOrNull(offsets[8]);
  object.notificationIds = reader.readLongList(offsets[9]) ?? [];
  object.reminderOffsets = reader.readLongList(offsets[10]) ?? [];
  return object;
}

P _documentReminderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLongList(offset) ?? []) as P;
    case 10:
      return (reader.readLongList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _documentReminderGetId(DocumentReminder object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _documentReminderGetLinks(DocumentReminder object) {
  return [];
}

void _documentReminderAttach(
    IsarCollection<dynamic> col, Id id, DocumentReminder object) {
  object.id = id;
}

extension DocumentReminderQueryWhereSort
    on QueryBuilder<DocumentReminder, DocumentReminder, QWhere> {
  QueryBuilder<DocumentReminder, DocumentReminder, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DocumentReminderQueryWhere
    on QueryBuilder<DocumentReminder, DocumentReminder, QWhereClause> {
  QueryBuilder<DocumentReminder, DocumentReminder, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterWhereClause>
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

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterWhereClause> idBetween(
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

extension DocumentReminderQueryFilter
    on QueryBuilder<DocumentReminder, DocumentReminder, QFilterCondition> {
  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      carIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carId',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
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

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
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

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
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

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'documentTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'documentTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'documentTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'documentTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'documentTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'documentTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'documentTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'documentTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'documentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'documentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentType',
        value: '',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      documentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'documentType',
        value: '',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      expiryDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      expiryDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      expiryDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      expiryDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiryDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
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

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
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

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
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

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'issueDate',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'issueDate',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issueDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'issueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issueDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'issueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issueDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'issueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issueDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'issueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issuingAuthorityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'issuingAuthority',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issuingAuthorityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'issuingAuthority',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issuingAuthorityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'issuingAuthority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issuingAuthorityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'issuingAuthority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issuingAuthorityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'issuingAuthority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issuingAuthorityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'issuingAuthority',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issuingAuthorityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'issuingAuthority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issuingAuthorityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'issuingAuthority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issuingAuthorityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'issuingAuthority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issuingAuthorityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'issuingAuthority',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issuingAuthorityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'issuingAuthority',
        value: '',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      issuingAuthorityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'issuingAuthority',
        value: '',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      lastNotifiedOffsetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastNotifiedOffset',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      lastNotifiedOffsetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastNotifiedOffset',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      lastNotifiedOffsetEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastNotifiedOffset',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      lastNotifiedOffsetGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastNotifiedOffset',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      lastNotifiedOffsetLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastNotifiedOffset',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      lastNotifiedOffsetBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastNotifiedOffset',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
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

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
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

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
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

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
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

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
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

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
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

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notificationIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationIds',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notificationIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationIds',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notificationIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationIds',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notificationIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notificationIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notificationIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notificationIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notificationIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notificationIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      notificationIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      reminderOffsetsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderOffsets',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      reminderOffsetsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reminderOffsets',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      reminderOffsetsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reminderOffsets',
        value: value,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      reminderOffsetsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reminderOffsets',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      reminderOffsetsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reminderOffsets',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      reminderOffsetsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reminderOffsets',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      reminderOffsetsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reminderOffsets',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      reminderOffsetsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reminderOffsets',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      reminderOffsetsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reminderOffsets',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterFilterCondition>
      reminderOffsetsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reminderOffsets',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension DocumentReminderQueryObject
    on QueryBuilder<DocumentReminder, DocumentReminder, QFilterCondition> {}

extension DocumentReminderQueryLinks
    on QueryBuilder<DocumentReminder, DocumentReminder, QFilterCondition> {}

extension DocumentReminderQuerySortBy
    on QueryBuilder<DocumentReminder, DocumentReminder, QSortBy> {
  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy> sortByCarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByCarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByDocumentTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentTitle', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByDocumentTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentTitle', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByDocumentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentType', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByDocumentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentType', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryDate', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByExpiryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryDate', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByIssueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issueDate', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByIssueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issueDate', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByIssuingAuthority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issuingAuthority', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByIssuingAuthorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issuingAuthority', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByLastNotifiedOffset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastNotifiedOffset', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByLastNotifiedOffsetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastNotifiedOffset', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }
}

extension DocumentReminderQuerySortThenBy
    on QueryBuilder<DocumentReminder, DocumentReminder, QSortThenBy> {
  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy> thenByCarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByCarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carId', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByDocumentTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentTitle', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByDocumentTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentTitle', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByDocumentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentType', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByDocumentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentType', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryDate', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByExpiryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiryDate', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByIssueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issueDate', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByIssueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issueDate', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByIssuingAuthority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issuingAuthority', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByIssuingAuthorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'issuingAuthority', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByLastNotifiedOffset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastNotifiedOffset', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByLastNotifiedOffsetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastNotifiedOffset', Sort.desc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }
}

extension DocumentReminderQueryWhereDistinct
    on QueryBuilder<DocumentReminder, DocumentReminder, QDistinct> {
  QueryBuilder<DocumentReminder, DocumentReminder, QDistinct>
      distinctByCarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carId');
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QDistinct>
      distinctByDocumentTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'documentTitle',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QDistinct>
      distinctByDocumentType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'documentType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QDistinct>
      distinctByExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiryDate');
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QDistinct>
      distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QDistinct>
      distinctByIssueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'issueDate');
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QDistinct>
      distinctByIssuingAuthority({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'issuingAuthority',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QDistinct>
      distinctByLastNotifiedOffset() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastNotifiedOffset');
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QDistinct>
      distinctByNotificationIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationIds');
    });
  }

  QueryBuilder<DocumentReminder, DocumentReminder, QDistinct>
      distinctByReminderOffsets() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderOffsets');
    });
  }
}

extension DocumentReminderQueryProperty
    on QueryBuilder<DocumentReminder, DocumentReminder, QQueryProperty> {
  QueryBuilder<DocumentReminder, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DocumentReminder, int, QQueryOperations> carIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carId');
    });
  }

  QueryBuilder<DocumentReminder, String, QQueryOperations>
      documentTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'documentTitle');
    });
  }

  QueryBuilder<DocumentReminder, String, QQueryOperations>
      documentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'documentType');
    });
  }

  QueryBuilder<DocumentReminder, DateTime, QQueryOperations>
      expiryDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiryDate');
    });
  }

  QueryBuilder<DocumentReminder, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<DocumentReminder, DateTime?, QQueryOperations>
      issueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'issueDate');
    });
  }

  QueryBuilder<DocumentReminder, String?, QQueryOperations>
      issuingAuthorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'issuingAuthority');
    });
  }

  QueryBuilder<DocumentReminder, int?, QQueryOperations>
      lastNotifiedOffsetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastNotifiedOffset');
    });
  }

  QueryBuilder<DocumentReminder, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<DocumentReminder, List<int>, QQueryOperations>
      notificationIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationIds');
    });
  }

  QueryBuilder<DocumentReminder, List<int>, QQueryOperations>
      reminderOffsetsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderOffsets');
    });
  }
}
