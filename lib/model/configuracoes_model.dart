// ignore_for_file: public_member_api_docs, sort_constructors_first
class ConfiguracoesModel {
  String _nomeUsuario = "";
  double _altura = 0;
  bool _receberpushnotification = false;
  bool _temaEscuro = false;

  ConfiguracoesModel(
    this._nomeUsuario,
    this._altura,
    this._receberpushnotification,
    this._temaEscuro,
  );
  ConfiguracoesModel.vazio() {
    _nomeUsuario = "";
    _altura = 0;
    _receberpushnotification = false;
    _temaEscuro = false;
  }
  String get nomeUsuario => _nomeUsuario;

  set nomeUsuario(String value) {
    _nomeUsuario = value;
  }

  double get altura => _altura;

  set altura(double value) {
    _altura = value;
  }

  bool get receberpushnotification => _receberpushnotification;

  set receberpushnotification(bool value) {
    _receberpushnotification = value;
  }

  bool get temaEscuro => _temaEscuro;
  
  set temaEscuro(bool value) {
    _temaEscuro = value;
  }
}
