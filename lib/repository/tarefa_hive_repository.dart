import 'package:hive/hive.dart';
import 'package:trilhaapp/model/tarefas_model.dart';

class TarefaHRepository {
  static late Box _box;

  TarefaHRepository._criar();

  static Future<TarefaHRepository> carregar() async {
    if (Hive.isBoxOpen('dadosCadastraisModel')) {
      _box = Hive.box('dadosCadastraisModel');
    } else {
      _box = await Hive.openBox('dadosCadastraisModel');
    }
    return TarefaHRepository._criar();
  }

  salvar(TarefasModel tarefasModel) {
    _box.add(tarefasModel);
  }

  alterar(TarefasModel tarefasModel) {
    tarefasModel.save();
  }

  excluir(TarefasModel tarefasModel) {
    tarefasModel.delete();
  }

  List<TarefasModel> obterDados(bool naoConcluido) {
    if (naoConcluido) {
      return _box.values
          .cast<TarefasModel>()
          .where((element) => !element.concluido)
          .toList();
    }
    return _box.values.cast<TarefasModel>().toList();
  }
}
