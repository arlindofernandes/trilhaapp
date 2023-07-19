import 'package:shared_preferences/shared_preferences.dart';

enum StorageChaves {
  chaveDadosNome,
  chaveDadosDataNasc,
  chaveDadosNivel,
  chaveDadosLinguagem,
  chaveDadosExperiencia,
  chaveDadosSalario,
  chaveUsuario,
  chaveAltura,
  chaveNotificacoes,
  chaveTema,
  chaveNumeroAleatorio,
  chaveQuantidade
}

class AppStorageServices {
  //dados cadastrais------------------------
  Future<void> setDadosNome(String nome) async {
    await _setString(StorageChaves.chaveDadosNome.toString(), nome);
  }

  Future<String> getDadosNome() async {
    return _getString(StorageChaves.chaveDadosNome.toString());
  }

  Future<void> setDadosDataNasc(DateTime data) async {
    await _setString(
        StorageChaves.chaveDadosDataNasc.toString(), data.toString());
  }

  Future<String> getDadosDataNasc() async {
    return _getString(StorageChaves.chaveDadosDataNasc.toString());
  }

  Future<void> setDadosNivel(String nivel) async {
    await _setString(StorageChaves.chaveDadosNivel.toString(), nivel);
  }

  Future<String> getDadosNivel() async {
    return _getString(StorageChaves.chaveDadosNivel.toString());
  }

  Future<void> setDadosLinguagens(List<String> values) async {
    _setStringList(StorageChaves.chaveDadosLinguagem.toString(), values);
  }

  Future<List<String>> getDadosLinguagens() async {
    return _getStringList(StorageChaves.chaveDadosLinguagem.toString());
  }

  Future<void> setDadosExperiencia(int value) async {
    _setInt(StorageChaves.chaveDadosExperiencia.toString(), value);
  }

  Future<int> getDadosExperiencia() async {
    return _getInt(StorageChaves.chaveDadosExperiencia.toString());
  }

  setDadosSalario(double value) async {
    _setDouble(StorageChaves.chaveDadosSalario.toString(), value);
  }

  Future<double> getDadosSalario() async {
    return _getDouble(StorageChaves.chaveDadosSalario.toString());
  }

  //----------------------------------------
  //dados configurações---------------------
  Future<void> setUsuario(String nome) async {
    await _setString(StorageChaves.chaveUsuario.toString(), nome);
  }

  Future<String> getUsario() async {
    return _getString(StorageChaves.chaveUsuario.toString());
  }

  Future<void> setAltura(double altura) async {
    await _setDouble(StorageChaves.chaveAltura.toString(), altura);
  }

  Future<double> getAltura() async {
    return _getDouble(StorageChaves.chaveAltura.toString());
  }

  Future<void> setNotificacoes(bool value) async {
    await _setBool(StorageChaves.chaveNotificacoes.toString(), value);
  }

  Future<bool> getNotificacoes() async {
    return _getBool(StorageChaves.chaveNotificacoes.toString());
  }

  Future<void> setTema(bool value) async {
    await _setBool(StorageChaves.chaveTema.toString(), value);
  }

  Future<bool> getTema() async {
    return _getBool(StorageChaves.chaveTema.toString());
  }

  //----------------------------------------
   Future<void> setNumeroAleatorio(int value) async {
    _setInt(StorageChaves.chaveNumeroAleatorio.toString(), value);
  }

  Future<int> getNumeroAleatorio() async {
    return _getInt(StorageChaves.chaveNumeroAleatorio.toString());
  }
  
 Future<void> setQuantidade(int value) async {
    _setInt(StorageChaves.chaveQuantidade.toString(), value);
  }

  Future<int> getQuantidade() async {
    return _getInt(StorageChaves.chaveQuantidade.toString());
  }
  
  Future<void> _setBool(String chave, bool value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setBool(chave, value);
  }

  Future<bool> _getBool(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(chave) ?? false;
  }

  Future<void> _setString(String chave, String value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(chave, value);
  }

  Future<String> _getString(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(chave) ?? "";
  }

  Future<void> _setInt(String chave, int value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setInt(chave, value);
  }

  Future<int> _getInt(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(chave) ?? 0;
  }

  Future<void> _setStringList(String chave, List<String> values) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setStringList(chave, values);
  }

  Future<List<String>> _getStringList(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getStringList(chave) ?? [];
  }

  Future<void> _setDouble(String chave, double value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setDouble(chave, value);
  }

  Future<double> _getDouble(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(chave) ?? 0;
  }
}
