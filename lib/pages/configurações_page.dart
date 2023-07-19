import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trilhaapp/services/app_storage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  AppStorageServices storage = AppStorageServices();
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String? nomeUsuario;
  double? altura;
  bool receberpushnotification = false;
  bool temaEscuro = false;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    nomeUsuarioController.text = await storage.getUsario();
    alturaController.text = (await storage.getAltura()).toString();
    receberpushnotification = await storage.getNotificacoes();
    temaEscuro = await storage.getTema();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
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
              value: receberpushnotification,
              onChanged: (bool value) {
                setState(() {
                  receberpushnotification = !receberpushnotification;
                });
              },
            ),
            SwitchListTile(
              title: const Text("Tema Escuro"),
              value: temaEscuro,
              onChanged: (bool value) {
                setState(() {
                  temaEscuro = value;
                });
              },
            ),
            TextButton(
              child: const Text("Salvar"),
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                try {
                  await storage
                      .setAltura(double.tryParse(alturaController.text) ?? 0);
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
                await storage.setUsuario(nomeUsuarioController.text);
                await storage.setNotificacoes(receberpushnotification);
                await storage.setTema(temaEscuro);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ));
  }
}
