import 'package:flutter/material.dart';
import 'package:trilhaapp/model/configuracoes_model.dart';
import 'package:trilhaapp/repository/configuracoes_repository.dart';

class SettingHivePage extends StatefulWidget {
  const SettingHivePage({super.key});

  @override
  State<SettingHivePage> createState() => _SettingHivePageState();
}

class _SettingHivePageState extends State<SettingHivePage> {
  late ConfiguracoesRepository configuracoesRepository;
  var configuracoesModel = ConfiguracoesModel.vazio();
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.load();
    configuracoesModel = configuracoesRepository.obterDados();

    nomeUsuarioController.text = configuracoesModel.nomeUsuario;
    alturaController.text = configuracoesModel.altura.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Configurações Hive"),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: const InputDecoration(hintText: "Nome Usuario"),
                controller: nomeUsuarioController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Altura"),
                controller: alturaController,
              ),
            ),
            SwitchListTile(
              title: const Text("Receber Notificações"),
              value: configuracoesModel.receberpushnotification,
              onChanged: (bool value) {
                setState(() {
                  configuracoesModel.receberpushnotification =
                      !configuracoesModel.receberpushnotification;
                });
              },
            ),
            SwitchListTile(
              title: const Text("Tema Escuro"),
              value: configuracoesModel.temaEscuro,
              onChanged: (bool value) {
                setState(() {
                  configuracoesModel.temaEscuro = value;
                });
              },
            ),
            TextButton(
              child: const Text("Salvar"),
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                try {
                  configuracoesModel.altura =
                      (double.tryParse(alturaController.text) ?? 0);
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text("Meu App"),
                          content:
                              const Text("favor imformar uma altura valida"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("ok"))
                          ],
                        );
                      });
                  return;
                }
                configuracoesModel.nomeUsuario = nomeUsuarioController.text;
                configuracoesRepository.salvar(configuracoesModel);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ));
  }
}
