import 'package:hive/hive.dart';
part 'dados_cadastrais_model.g.dart';

@HiveType(typeId: 0)
class DadosCadastrais extends HiveObject {
  @HiveField(0)
  String? nome;

  @HiveField(1)
  DateTime? dataNasc;

  @HiveField(2)
  String? nivel;

  @HiveField(3)
  List<String> linguagens = [];

  @HiveField(4)
  double? salario;

  @HiveField(5)
  int? tempoExperiencia;

  DadosCadastrais();
  
  DadosCadastrais.vazio() {
    nome = "";
    dataNasc = null;
    nivel = "";
    linguagens = [];
    tempoExperiencia = 0;
  }
}
