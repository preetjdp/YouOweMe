// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OweAdapter extends TypeAdapter<Owe> {
  @override
  final typeId = 1;

  @override
  Owe read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Owe(
      title: fields[0] as String,
      created: fields[3] as DateTime,
    )
      ..owedBy = fields[1] as String
      ..amount = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, Owe obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.owedBy)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.created);
  }
}
