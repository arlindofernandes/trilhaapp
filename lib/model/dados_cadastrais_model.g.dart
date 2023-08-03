// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dados_cadastrais_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DadosCadastraisAdapter extends TypeAdapter<DadosCadastrais> {
  @override
  final int typeId = 0;

  @override
  DadosCadastrais read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DadosCadastrais()
      ..nome = fields[0] as String?
      ..dataNasc = fields[1] as DateTime?
      ..nivel = fields[2] as String?
      ..linguagens = (fields[3] as List).cast<String>()
      ..salario = fields[4] as double?
      ..tempoExperiencia = fields[5] as int?;
  }

  @override
  void write(BinaryWriter writer, DadosCadastrais obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.dataNasc)
      ..writeByte(2)
      ..write(obj.nivel)
      ..writeByte(3)
      ..write(obj.linguagens)
      ..writeByte(4)
      ..write(obj.salario)
      ..writeByte(5)
      ..write(obj.tempoExperiencia);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DadosCadastraisAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
