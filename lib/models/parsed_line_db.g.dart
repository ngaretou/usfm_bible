// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_line_db.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetParsedLineDBCollection on Isar {
  IsarCollection<ParsedLineDB> get parsedLineDBs => getCollection();
}

const ParsedLineDBSchema = CollectionSchema(
  name: 'ParsedLineDB',
  schema:
      '{"name":"ParsedLineDB","idName":"isarId","properties":[{"name":"audioMarker","type":"String"},{"name":"book","type":"String"},{"name":"chapter","type":"String"},{"name":"collectionid","type":"String"},{"name":"verse","type":"String"},{"name":"verseFragment","type":"String"},{"name":"verseStyle","type":"String"},{"name":"verseText","type":"String"}],"indexes":[],"links":[]}',
  idName: 'isarId',
  propertyIds: {
    'audioMarker': 0,
    'book': 1,
    'chapter': 2,
    'collectionid': 3,
    'verse': 4,
    'verseFragment': 5,
    'verseStyle': 6,
    'verseText': 7
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _parsedLineDBGetId,
  setId: _parsedLineDBSetId,
  getLinks: _parsedLineDBGetLinks,
  attachLinks: _parsedLineDBAttachLinks,
  serializeNative: _parsedLineDBSerializeNative,
  deserializeNative: _parsedLineDBDeserializeNative,
  deserializePropNative: _parsedLineDBDeserializePropNative,
  serializeWeb: _parsedLineDBSerializeWeb,
  deserializeWeb: _parsedLineDBDeserializeWeb,
  deserializePropWeb: _parsedLineDBDeserializePropWeb,
  version: 3,
);

int? _parsedLineDBGetId(ParsedLineDB object) {
  if (object.isarId == Isar.autoIncrement) {
    return null;
  } else {
    return object.isarId;
  }
}

void _parsedLineDBSetId(ParsedLineDB object, int id) {
  object.isarId = id;
}

List<IsarLinkBase> _parsedLineDBGetLinks(ParsedLineDB object) {
  return [];
}

void _parsedLineDBSerializeNative(
    IsarCollection<ParsedLineDB> collection,
    IsarRawObject rawObj,
    ParsedLineDB object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.audioMarker;
  final _audioMarker = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_audioMarker.length) as int;
  final value1 = object.book;
  final _book = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_book.length) as int;
  final value2 = object.chapter;
  final _chapter = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_chapter.length) as int;
  final value3 = object.collectionid;
  final _collectionid = IsarBinaryWriter.utf8Encoder.convert(value3);
  dynamicSize += (_collectionid.length) as int;
  final value4 = object.verse;
  final _verse = IsarBinaryWriter.utf8Encoder.convert(value4);
  dynamicSize += (_verse.length) as int;
  final value5 = object.verseFragment;
  final _verseFragment = IsarBinaryWriter.utf8Encoder.convert(value5);
  dynamicSize += (_verseFragment.length) as int;
  final value6 = object.verseStyle;
  final _verseStyle = IsarBinaryWriter.utf8Encoder.convert(value6);
  dynamicSize += (_verseStyle.length) as int;
  final value7 = object.verseText;
  final _verseText = IsarBinaryWriter.utf8Encoder.convert(value7);
  dynamicSize += (_verseText.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _audioMarker);
  writer.writeBytes(offsets[1], _book);
  writer.writeBytes(offsets[2], _chapter);
  writer.writeBytes(offsets[3], _collectionid);
  writer.writeBytes(offsets[4], _verse);
  writer.writeBytes(offsets[5], _verseFragment);
  writer.writeBytes(offsets[6], _verseStyle);
  writer.writeBytes(offsets[7], _verseText);
}

ParsedLineDB _parsedLineDBDeserializeNative(
    IsarCollection<ParsedLineDB> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
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

P _parsedLineDBDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
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
      throw 'Illegal propertyIndex';
  }
}

dynamic _parsedLineDBSerializeWeb(
    IsarCollection<ParsedLineDB> collection, ParsedLineDB object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'audioMarker', object.audioMarker);
  IsarNative.jsObjectSet(jsObj, 'book', object.book);
  IsarNative.jsObjectSet(jsObj, 'chapter', object.chapter);
  IsarNative.jsObjectSet(jsObj, 'collectionid', object.collectionid);
  IsarNative.jsObjectSet(jsObj, 'isarId', object.isarId);
  IsarNative.jsObjectSet(jsObj, 'verse', object.verse);
  IsarNative.jsObjectSet(jsObj, 'verseFragment', object.verseFragment);
  IsarNative.jsObjectSet(jsObj, 'verseStyle', object.verseStyle);
  IsarNative.jsObjectSet(jsObj, 'verseText', object.verseText);
  return jsObj;
}

ParsedLineDB _parsedLineDBDeserializeWeb(
    IsarCollection<ParsedLineDB> collection, dynamic jsObj) {
  final object = ParsedLineDB();
  object.audioMarker = IsarNative.jsObjectGet(jsObj, 'audioMarker') ?? '';
  object.book = IsarNative.jsObjectGet(jsObj, 'book') ?? '';
  object.chapter = IsarNative.jsObjectGet(jsObj, 'chapter') ?? '';
  object.collectionid = IsarNative.jsObjectGet(jsObj, 'collectionid') ?? '';
  object.isarId =
      IsarNative.jsObjectGet(jsObj, 'isarId') ?? double.negativeInfinity;
  object.verse = IsarNative.jsObjectGet(jsObj, 'verse') ?? '';
  object.verseFragment = IsarNative.jsObjectGet(jsObj, 'verseFragment') ?? '';
  object.verseStyle = IsarNative.jsObjectGet(jsObj, 'verseStyle') ?? '';
  object.verseText = IsarNative.jsObjectGet(jsObj, 'verseText') ?? '';
  return object;
}

P _parsedLineDBDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'audioMarker':
      return (IsarNative.jsObjectGet(jsObj, 'audioMarker') ?? '') as P;
    case 'book':
      return (IsarNative.jsObjectGet(jsObj, 'book') ?? '') as P;
    case 'chapter':
      return (IsarNative.jsObjectGet(jsObj, 'chapter') ?? '') as P;
    case 'collectionid':
      return (IsarNative.jsObjectGet(jsObj, 'collectionid') ?? '') as P;
    case 'isarId':
      return (IsarNative.jsObjectGet(jsObj, 'isarId') ??
          double.negativeInfinity) as P;
    case 'verse':
      return (IsarNative.jsObjectGet(jsObj, 'verse') ?? '') as P;
    case 'verseFragment':
      return (IsarNative.jsObjectGet(jsObj, 'verseFragment') ?? '') as P;
    case 'verseStyle':
      return (IsarNative.jsObjectGet(jsObj, 'verseStyle') ?? '') as P;
    case 'verseText':
      return (IsarNative.jsObjectGet(jsObj, 'verseText') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _parsedLineDBAttachLinks(
    IsarCollection col, int id, ParsedLineDB object) {}

extension ParsedLineDBQueryWhereSort
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QWhere> {
  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterWhere> anyIsarId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension ParsedLineDBQueryWhere
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QWhereClause> {
  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterWhereClause> isarIdEqualTo(
      int isarId) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: isarId,
      includeLower: true,
      upper: isarId,
      includeUpper: true,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterWhereClause> isarIdNotEqualTo(
      int isarId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: isarId, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: isarId, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: isarId, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: isarId, includeUpper: false),
      );
    }
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterWhereClause> isarIdGreaterThan(
      int isarId,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: isarId, includeLower: include),
    );
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterWhereClause> isarIdLessThan(
      int isarId,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: isarId, includeUpper: include),
    );
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterWhereClause> isarIdBetween(
    int lowerIsarId,
    int upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerIsarId,
      includeLower: includeLower,
      upper: upperIsarId,
      includeUpper: includeUpper,
    ));
  }
}

extension ParsedLineDBQueryFilter
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QFilterCondition> {
  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'audioMarker',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'audioMarker',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'audioMarker',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'audioMarker',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'audioMarker',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'audioMarker',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'audioMarker',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      audioMarkerMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'audioMarker',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> bookEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'book',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      bookGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'book',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> bookLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'book',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> bookBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'book',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      bookStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'book',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> bookEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'book',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> bookContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'book',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> bookMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'book',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'chapter',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'chapter',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'chapter',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'chapter',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'chapter',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'chapter',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'chapter',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      chapterMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'chapter',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'collectionid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'collectionid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'collectionid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'collectionid',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'collectionid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'collectionid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'collectionid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      collectionidMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'collectionid',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> isarIdEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      isarIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      isarIdLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'isarId',
      value: value,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> isarIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'isarId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> verseEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'verse',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'verse',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> verseLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'verse',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> verseBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'verse',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'verse',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> verseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'verse',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> verseContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'verse',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition> verseMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'verse',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'verseFragment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'verseFragment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'verseFragment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'verseFragment',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'verseFragment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'verseFragment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'verseFragment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseFragmentMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'verseFragment',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'verseStyle',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'verseStyle',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'verseStyle',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'verseStyle',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'verseStyle',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'verseStyle',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'verseStyle',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseStyleMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'verseStyle',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'verseText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'verseText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'verseText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'verseText',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'verseText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'verseText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'verseText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterFilterCondition>
      verseTextMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'verseText',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ParsedLineDBQueryLinks
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QFilterCondition> {}

extension ParsedLineDBQueryWhereSortBy
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QSortBy> {
  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByAudioMarker() {
    return addSortByInternal('audioMarker', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      sortByAudioMarkerDesc() {
    return addSortByInternal('audioMarker', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByBook() {
    return addSortByInternal('book', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByBookDesc() {
    return addSortByInternal('book', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByChapter() {
    return addSortByInternal('chapter', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByChapterDesc() {
    return addSortByInternal('chapter', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByCollectionid() {
    return addSortByInternal('collectionid', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      sortByCollectionidDesc() {
    return addSortByInternal('collectionid', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByVerse() {
    return addSortByInternal('verse', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByVerseDesc() {
    return addSortByInternal('verse', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByVerseFragment() {
    return addSortByInternal('verseFragment', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      sortByVerseFragmentDesc() {
    return addSortByInternal('verseFragment', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByVerseStyle() {
    return addSortByInternal('verseStyle', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      sortByVerseStyleDesc() {
    return addSortByInternal('verseStyle', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByVerseText() {
    return addSortByInternal('verseText', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> sortByVerseTextDesc() {
    return addSortByInternal('verseText', Sort.desc);
  }
}

extension ParsedLineDBQueryWhereSortThenBy
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QSortThenBy> {
  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByAudioMarker() {
    return addSortByInternal('audioMarker', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      thenByAudioMarkerDesc() {
    return addSortByInternal('audioMarker', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByBook() {
    return addSortByInternal('book', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByBookDesc() {
    return addSortByInternal('book', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByChapter() {
    return addSortByInternal('chapter', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByChapterDesc() {
    return addSortByInternal('chapter', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByCollectionid() {
    return addSortByInternal('collectionid', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      thenByCollectionidDesc() {
    return addSortByInternal('collectionid', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByIsarId() {
    return addSortByInternal('isarId', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByIsarIdDesc() {
    return addSortByInternal('isarId', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByVerse() {
    return addSortByInternal('verse', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByVerseDesc() {
    return addSortByInternal('verse', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByVerseFragment() {
    return addSortByInternal('verseFragment', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      thenByVerseFragmentDesc() {
    return addSortByInternal('verseFragment', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByVerseStyle() {
    return addSortByInternal('verseStyle', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy>
      thenByVerseStyleDesc() {
    return addSortByInternal('verseStyle', Sort.desc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByVerseText() {
    return addSortByInternal('verseText', Sort.asc);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QAfterSortBy> thenByVerseTextDesc() {
    return addSortByInternal('verseText', Sort.desc);
  }
}

extension ParsedLineDBQueryWhereDistinct
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> {
  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByAudioMarker(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('audioMarker', caseSensitive: caseSensitive);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByBook(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('book', caseSensitive: caseSensitive);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByChapter(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('chapter', caseSensitive: caseSensitive);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByCollectionid(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('collectionid', caseSensitive: caseSensitive);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByIsarId() {
    return addDistinctByInternal('isarId');
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByVerse(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('verse', caseSensitive: caseSensitive);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByVerseFragment(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('verseFragment', caseSensitive: caseSensitive);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByVerseStyle(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('verseStyle', caseSensitive: caseSensitive);
  }

  QueryBuilder<ParsedLineDB, ParsedLineDB, QDistinct> distinctByVerseText(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('verseText', caseSensitive: caseSensitive);
  }
}

extension ParsedLineDBQueryProperty
    on QueryBuilder<ParsedLineDB, ParsedLineDB, QQueryProperty> {
  QueryBuilder<ParsedLineDB, String, QQueryOperations> audioMarkerProperty() {
    return addPropertyNameInternal('audioMarker');
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> bookProperty() {
    return addPropertyNameInternal('book');
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> chapterProperty() {
    return addPropertyNameInternal('chapter');
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> collectionidProperty() {
    return addPropertyNameInternal('collectionid');
  }

  QueryBuilder<ParsedLineDB, int, QQueryOperations> isarIdProperty() {
    return addPropertyNameInternal('isarId');
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> verseProperty() {
    return addPropertyNameInternal('verse');
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> verseFragmentProperty() {
    return addPropertyNameInternal('verseFragment');
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> verseStyleProperty() {
    return addPropertyNameInternal('verseStyle');
  }

  QueryBuilder<ParsedLineDB, String, QQueryOperations> verseTextProperty() {
    return addPropertyNameInternal('verseText');
  }
}
