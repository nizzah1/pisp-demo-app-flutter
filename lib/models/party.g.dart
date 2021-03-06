// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Party _$PartyFromJson(Map<String, dynamic> json) {
  return Party(
    name: json['name'] as String,
    partyIdInfo: json['partyIdInfo'] == null
        ? null
        : PartyIdInfo.fromJson(json['partyIdInfo'] as Map<String, dynamic>),
    merchantClassificationCode: json['merchantClassificationCode'] as String,
    personalInfo: json['personalInfo'] == null
        ? null
        : PartyPersonalInfo.fromJson(
            json['personalInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PartyToJson(Party instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('partyIdInfo', instance.partyIdInfo?.toJson());
  writeNotNull(
      'merchantClassificationCode', instance.merchantClassificationCode);
  writeNotNull('personalInfo', instance.personalInfo?.toJson());
  return val;
}

PartyIdInfo _$PartyIdInfoFromJson(Map<String, dynamic> json) {
  return PartyIdInfo(
    fspId: json['fspId'] as String,
    partyIdType:
        _$enumDecodeNullable(_$PartyIdTypeEnumMap, json['partyIdType']),
    partySubIdOrType: json['partySubIdOrType'] as String,
    partyIdentifier: json['partyIdentifier'] as String,
  );
}

Map<String, dynamic> _$PartyIdInfoToJson(PartyIdInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('partyIdType', _$PartyIdTypeEnumMap[instance.partyIdType]);
  writeNotNull('partyIdentifier', instance.partyIdentifier);
  writeNotNull('partySubIdOrType', instance.partySubIdOrType);
  writeNotNull('fspId', instance.fspId);
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PartyIdTypeEnumMap = {
  PartyIdType.msisdn: 'MSISDN',
  PartyIdType.opaque: 'OPAQUE',
};

PartyPersonalInfo _$PartyPersonalInfoFromJson(Map<String, dynamic> json) {
  return PartyPersonalInfo(
    complexName: json['complexName'] == null
        ? null
        : PartyComplexName.fromJson(
            json['complexName'] as Map<String, dynamic>),
    dateOfBirth: json['dateOfBirth'] as String,
  );
}

Map<String, dynamic> _$PartyPersonalInfoToJson(PartyPersonalInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('complexName', instance.complexName?.toJson());
  writeNotNull('dateOfBirth', instance.dateOfBirth);
  return val;
}

PartyComplexName _$PartyComplexNameFromJson(Map<String, dynamic> json) {
  return PartyComplexName(
    firstName: json['firstName'] as String,
    middleName: json['middleName'] as String,
    lastName: json['lastName'] as String,
  );
}

Map<String, dynamic> _$PartyComplexNameToJson(PartyComplexName instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firstName', instance.firstName);
  writeNotNull('middleName', instance.middleName);
  writeNotNull('lastName', instance.lastName);
  return val;
}
