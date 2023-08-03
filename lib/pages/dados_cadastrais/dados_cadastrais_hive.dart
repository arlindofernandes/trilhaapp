import 'package:flutter/material.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';
import 'package:trilhaapp/repository/dados_cadastrais_repository.dart';
import 'package:trilhaapp/repository/linguagens_reporitory.dart';
import 'package:trilhaapp/repository/nivel_repository.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class DadosCadastraisHivePage extends StatefulWidget {
  const DadosCadastraisHivePage({
    super.key,
  });

  @override
  State<DadosCadastraisHivePage> createState() =>
      _DadosCadastraisHivePageState();
}

class _DadosCadastraisHivePageState extends State<DadosCadastraisHivePage> {
  late DadosCadastraisRepository dadosCadastraisRepository;
  var dadosModel = DadosCadastrais.vazio();

  TextEditingController nomeController = TextEditingController(text: "");
  TextEditingController dataController = TextEditingController(text: "");
  var niveis = [];
  var linguagens = [];

  bool salvando = false;
  @override
  void initState() {
    niveis = NivelRepository().retornaniveis();
    linguagens = LinguagensRepository().retornaLinguagens();
    super.initState();
    carregarDados();
  }

  List<DropdownMenuItem> returnItens(int quant) {
    var itens = <DropdownMenuItem>[];
    for (var i = 0; i <= quant; i++) {
      itens.add(DropdownMenuItem(
        value: i,
        child: Text(i.toString()),
      ));
    }
    return itens;
  }

  carregarDados() async {
    dadosCadastraisRepository = await DadosCadastraisRepository.load();
    dadosModel = dadosCadastraisRepository.obterDados();
    nomeController.text = dadosModel.nome ?? "";
    dataController.text =
        dadosModel.dataNasc == null ? "" : dadosModel.dataNasc.toString();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Dados"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: salvando
            ? const Center(child: CircularProgressIndicator())
            : ListView(children: [
                const TextLabel(
                  texto: "Nome",
                ),
                TextField(
                  controller: nomeController,
                ),
                const TextLabel(texto: "Data de nascimento"),
                TextField(
                  controller: dataController,
                  readOnly: true,
                  onTap: () async {
                    var data = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000, 1, 1),
                      lastDate: DateTime(2023, 12, 31),
                    );
                    if (data != null) {
                      dataController.text = data.toString();
                      dadosModel.dataNasc = data;
                    }
                  },
                ),
                const TextLabel(texto: "Nivel de experiencia"),
                Column(
                  children: niveis
                      .map(
                        (e) => RadioListTile(
                          title: Text(e.toString()),
                          selected: dadosModel.nivel == e,
                          value: e.toString(),
                          groupValue: dadosModel.nivel,
                          onChanged: (value) {
                            setState(() {
                              dadosModel.nivel = value.toString();
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
                const TextLabel(texto: "Linguagens Preferidas"),
                Column(
                  children: linguagens
                      .map((linguagem) => CheckboxListTile(
                            dense: true,
                            title: Text(linguagem.toString()),
                            value: dadosModel.linguagens.contains(linguagem),
                            onChanged: (bool? value) {
                              if (value!) {
                                setState(() {
                                  dadosModel.linguagens.add(linguagem);
                                });
                              } else {
                                setState(() {
                                  dadosModel.linguagens.remove(linguagem);
                                });
                              }
                            },
                          ))
                      .toList(),
                ),
                const TextLabel(texto: "Tempo de Experiencia"),
                DropdownButton(
                  value: dadosModel.tempoExperiencia,
                  isExpanded: true,
                  items: returnItens(10),
                  onChanged: (value) {
                    setState(() {
                      dadosModel.tempoExperiencia = int.parse(value.toString());
                    });
                  },
                ),
                TextLabel(
                    texto:
                        "Pretenção salarial R\$ ${dadosModel.salario?.round()}"),
                Slider(
                  min: 0,
                  max: 10000,
                  value: dadosModel.salario ?? 0,
                  onChanged: (double value) {
                    setState(() {
                      dadosModel.salario = value;
                    });
                  },
                ),
                TextButton(
                    onPressed: () async {
                      setState(() {
                        salvando = false;
                      });
                      if (nomeController.text.trim().length < 3) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("o nome deve ser preenchido")));
                        return;
                      }
                      if (dadosModel.dataNasc == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("data nascimento invalida")));
                        return;
                      }
                      if (dadosModel.nivel == null ||
                          dadosModel.nivel!.trim() == '') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "o nivel deve ser selecionado nascimento invalida")));
                        return;
                      }
                      if (dadosModel.linguagens.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "deve ser selecionado no mimino uma linguagem")));
                        return;
                      }
                      if (dadosModel.salario == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("selecionar salario")));
                        return;
                      }
                      dadosModel.nome = nomeController.text;
                      dadosCadastraisRepository.salvar(dadosModel);

                      setState(() {
                        salvando = true;
                      });
                      Future.delayed(const Duration(seconds: 3), () {
                        setState(() {
                          salvando = false;
                        });

                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Salvar"))
              ]),
      ),
    );
  }
}
