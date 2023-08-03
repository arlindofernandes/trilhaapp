// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarefas_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TarefasModelAdapter extends TypeAdapter<TarefasModel> {
  @override
  final int typeId = 1;

  @override
  TarefasModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TarefasModel()
      ..descricao = fields[0] as String
      ..concluido = fields[1] as bool;
  }

  @override
  void write(BinaryWriter writer, TarefasModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.descricao)
      ..writeByte(1)
      ..write(obj.concluido);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TarefasModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
