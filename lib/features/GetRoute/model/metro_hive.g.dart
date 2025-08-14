// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metro_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MetroModelHiveAdapter extends TypeAdapter<MetroModelHive> {
  @override
  final int typeId = 0;

  @override
  MetroModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MetroModelHive(
      ticketPrice: fields[6] as num,
      expectedTime: fields[7] as int,
      time: fields[5] as DateTime,
      end: fields[1] as String,
      start: fields[0] as String,
      firstRoute: fields[2] as String,
      secondRoute: fields[3] as String?,
      thirdRoute: fields[4] as String?,
      noOFStation: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MetroModelHive obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.start)
      ..writeByte(1)
      ..write(obj.end)
      ..writeByte(2)
      ..write(obj.firstRoute)
      ..writeByte(3)
      ..write(obj.secondRoute)
      ..writeByte(4)
      ..write(obj.thirdRoute)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.ticketPrice)
      ..writeByte(7)
      ..write(obj.expectedTime)
      ..writeByte(8)
      ..write(obj.noOFStation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetroModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
