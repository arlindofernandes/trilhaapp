import 'package:hive/hive.dart';
import 'package:trilhaapp/model/configuracoes_model.dart';

class ConfiguracoesRepository {
  static late Box _box;

  ConfiguracoesRepository._create();

  static Future<ConfiguracoesRepository> load() async {
    if (Hive.isBoxOpen('configuracoes')) {
      _box = Hive.box('configuracoes');
    } else {
      _box = await Hive.openBox('configuracoes');
    }
    return ConfiguracoesRepository._create();
  }

  void salvar(ConfiguracoesModel cm) {
    _box.put('configuracoesModel', {
      'nomeUsuario': cm.nomeUsuario,
      'altura': cm.altura,
      'receberpushnotification': cm.receberpushnotification,
      'temaEscuro': cm.temaEscuro,
    });
  }

  ConfiguracoesModel obterDados() {
    var conf = _box.get('configuracoesModel');
    if (conf == null) {
      return ConfiguracoesModel.vazio();
    } else {
      return ConfiguracoesModel(conf["nomeUsuario"], conf["altura"],
          conf["receberpushnotification"], conf["temaEscuro"]);
    }
  }
}
