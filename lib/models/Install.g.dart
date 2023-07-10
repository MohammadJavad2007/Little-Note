// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Install.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InstallAdapter extends TypeAdapter<Install> {
  @override
  final int typeId = 1;

  @override
  Install read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Install(
      install: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Install obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.install);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstallAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
