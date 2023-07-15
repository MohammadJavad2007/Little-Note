// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lang.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LangAdapter extends TypeAdapter<Lang> {
  @override
  final int typeId = 3;

  @override
  Lang read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lang(
      lang: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Lang obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.lang);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LangAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
