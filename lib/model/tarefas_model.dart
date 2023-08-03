// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'tarefas_model.g.dart';

@HiveType(typeId: 1)
class TarefasModel extends HiveObject {
  @HiveField(0)
  String descricao = "";

  @HiveField(1)
  bool concluido = false;

  TarefasModel();

  TarefasModel.create(this.descricao, this.concluido);
}
