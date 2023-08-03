import 'package:hive/hive.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';

class DadosCadastraisRepository {
  static late Box _box;

  DadosCadastraisRepository._create();

  static Future<DadosCadastraisRepository> load() async {
    if (Hive.isBoxOpen('DadosCadastraisModel')) {
      _box = Hive.box('DadosCadastraisModel');
    } else {
      _box = await Hive.openBox('DadosCadastraisModel');
    }
    return DadosCadastraisRepository._create();
  }

  void salvar(DadosCadastrais dc) {
    _box.put('DadosCadastraisModel', dc);
  }

  DadosCadastrais obterDados() {
    var dados = _box.get('DadosCadastraisModel');
    if (dados == null) {
      return DadosCadastrais.vazio();
    } else {
      return dados;
    }
  }
}
