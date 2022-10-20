// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_line_db.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetParsedLineDBCollection on Isar {
  IsarCollection<ParsedLineDB> get parsedLineDBs => this.collection();
}

const ParsedLineDBSchema = CollectionSchema(
  name: r'ParsedLineDB',
  id: 1,
  properties: {
    r'audioMarker': PropertySchema(
      id: 0,
      name: r'audioMarker',
      type: IsarType.string,
    ),
    r'book': PropertySchema(
      id: 1,
      name: r'book',
      type: IsarType.string,
    ),
    r'chapter': PropertySchema(
      id: 2,
      name: r'chapter',
      type: IsarType.string,
    ),
    r'collectionid': PropertySchema(
      id: 3,
      name: r'collectionid',
      type: IsarType.string,
    ),
    r'verse': PropertySchema(
      id: 4,
      name: r'verse',
      type: IsarType.string,
    ),
    r'verseFragment': PropertySchema(
      id: 5,
      name: r'verseFragment',
      type: IsarType.string,
    ),
    r'verseStyle': PropertySchema(
      id: 6,
      name: r'verseStyle',
      type: IsarType.string,
    ),
    r'verseText': PropertySchema(
      id: 7,
      name: r'verseText',
      type: IsarType.string,
    )
  },
  estimateSize: _parsedLineDBEstimateSize,
  serialize: _parsedLineDBSerialize,
  deserialize: _parsedLineDBDeserialize,
  deserializeProp: _parsedLineDBDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _parsedLineDBGetId,
  getLinks: _parsedLineDBGetLinks,
  attach: _parsedLineDBAttach,
  version: '3.0.2',
);

int _parsedLineDBEstimateSize(
  ParsedLineDB object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.audioMarker.length * 3;
  bytesCount += 3 + object.book.length * 3;
  bytesCount += 3 + object.chapter.length * 3;
  bytesCount += 3 + object.collectionid.length * 3;
  bytesCount += 3 + object.verse.length * 3;
  bytesCount += 3 + object.verseFragment.length * 3;
  bytesCount += 3 + object.verseStyle.length * 3;
  bytesCount += 3 + object.verseText.length * 3;
  return bytesCount;
}

void _parsedLineDBSerialize(
  ParsedLineDB object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.audioMarker);
  writer.writeString(offsets[1], object.book);
  writer.writeString(offsets[2], object.chapter);
  writer.writeString(offsets[3], object.collectionid);
  writer.writeString(offsets[4], object.verse);
  writer.writeString(offsets[5], object.verseFragment);
  writer.writeString(offsets[6], object.verseStyle);
  writer.writeString(offsets[7], object.verseText);
}

ParsedLineDB _parsedLineDBDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ParsedLineDB();
  object.audioMarker = reader.readString(offsets[0]);
  object.book = reader.readString(offsets[1]);
  object.chapter = reader.readString(offsets[2]);
  object.collectionid = reader.readString(offsets[3]);
  object.isarId = id;
  object.verse = reader.readString(offsets[4]);
  object.verseFragment = reader.readString(offsets[5]);
  object.verseStyle = reader.readString(offsets[6]);
  object.verseText = reader.readString(offsets[7]);
  return object;
}

P _parsedLineDBDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _parsedLineDBGetId(ParsedLineDB object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _parsedLineDBGetLinks(ParsedLineDB object) {
  return [];
}

void _parsedLineDBAttach(
    IsarCollection<dynamic> col, Id id, ParsedLineDB object) {
  object.isarId = id;
}

extension ParsedLineDBQueryWhereSort
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QWhere> {
  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ParsedLineDBQueryWhere
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QWhereClause> {
  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ParsedLineDBQueryFilter
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QFilterCondition> {
  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioMarker',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioMarker',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioMarker',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioMarker',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audioMarker',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audioMarker',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audioMarker',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audioMarker',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioMarker',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audioMarker',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> bookEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'book',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      bookGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'book',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> bookLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'book',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> bookBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'book',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      bookStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'book',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> bookEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'book',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> bookContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'book',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> bookMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'book',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      bookIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'book',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      bookIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'book',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chapter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapter',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chapter',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collectionid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'collectionid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'collectionid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'collectionid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'collectionid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'collectionid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'collectionid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'collectionid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collectionid',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'collectionid',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> verseEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> verseLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> verseBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verse',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'verse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> verseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'verse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> verseContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'verse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> verseMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'verse',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verse',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'verse',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verseFragment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verseFragment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verseFragment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verseFragment',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'verseFragment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'verseFragment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'verseFragment',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'verseFragment',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verseFragment',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'verseFragment',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verseStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verseStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verseStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verseStyle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'verseStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'verseStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'verseStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'verseStyle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verseStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'verseStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verseText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verseText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verseText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verseText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'verseText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'verseText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'verseText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'verseText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verseText',
        value: '',
      ));
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'verseText',
        value: '',
      ));
    });
  }
}

extension ParsedLineDBQueryObject
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QFilterCondition> {}

extension ParsedLineDBQueryLinks
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QFilterCondition> {}

extension ParsedLineDBQuerySortBy
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QSortBy> {
  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByAudioMarker() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioMarker', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      sortByAudioMarkerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioMarker', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByBook() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'book', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByBookDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'book', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByChapterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByCollectionid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionid', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      sortByCollectionidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionid', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByVerse() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByVerseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByVerseFragment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verseFragment', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      sortByVerseFragmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verseFragment', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByVerseStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verseStyle', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      sortByVerseStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verseStyle', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByVerseText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verseText', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByVerseTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verseText', Sort.desc);
    });
  }
}

extension ParsedLineDBQuerySortThenBy
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QSortThenBy> {
  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByAudioMarker() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioMarker', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      thenByAudioMarkerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioMarker', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByBook() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'book', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByBookDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'book', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByChapterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapter', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByCollectionid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionid', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      thenByCollectionidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionid', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByVerse() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByVerseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByVerseFragment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verseFragment', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      thenByVerseFragmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verseFragment', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByVerseStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verseStyle', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      thenByVerseStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verseStyle', Sort.desc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByVerseText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verseText', Sort.asc);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByVerseTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verseText', Sort.desc);
    });
  }
}

extension ParsedLineDBQueryWhereDistinct
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> {
  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByAudioMarker(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioMarker', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByBook(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'book', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByChapter(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapter', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByCollectionid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'collectionid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByVerse(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verse', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByVerseFragment(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verseFragment',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByVerseStyle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verseStyle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByVerseText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verseText', caseSensitive: caseSensitive);
    });
  }
}

extension ParsedLineDBQueryProperty
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QQueryProperty> {
  QueryBuilder<ParsedLineDB, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> audioMarkerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioMarker');
    });
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> bookProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'book');
    });
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> chapterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapter');
    });
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> collectionidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'collectionid');
    });
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> verseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verse');
    });
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> verseFragmentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verseFragment');
    });
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> verseStyleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verseStyle');
    });
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> verseTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verseText');
    });
  }
}
