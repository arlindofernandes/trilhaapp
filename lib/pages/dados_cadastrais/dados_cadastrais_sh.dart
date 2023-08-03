import 'package:flutter/material.dart';
import 'package:trilhaapp/repository/linguagens_reporitory.dart';
import 'package:trilhaapp/repository/nivel_repository.dart';
import 'package:trilhaapp/services/app_storage.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class DadosCadastraisPage extends StatefulWidget {
  const DadosCadastraisPage({
    super.key,
  });

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  TextEditingController nomeController = TextEditingController(text: "");
  TextEditingController dataController = TextEditingController(text: "");
  DateTime? dataNasc;
  var niveis = [];
  var linguagens = [];

  var nivelselecionado = "";
  List<String> linguagemSelecionadas = [];
  double salarioescolhido = 0;
  int tempoExperiencia = 0;
  AppStorageServices storage = AppStorageServices();

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
    nomeController.text = await storage.getDadosNome();
    dataController.text = await storage.getDadosDataNasc();
    if (dataController.text.isNotEmpty) {
      dataNasc = DateTime.parse(dataController.text);
    }
    nivelselecionado = await storage.getDadosNivel();
    linguagemSelecionadas = await storage.getDadosLinguagens();
    tempoExperiencia = await storage.getDadosExperiencia();
    salarioescolhido = await storage.getDadosSalario();
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
                      dataNasc = data;
                    }
                  },
                ),
                const TextLabel(texto: "Nivel de experiencia"),
                Column(
                  children: niveis
                      .map(
                        (e) => RadioListTile(
                          title: Text(e.toString()),
                          selected: nivelselecionado == e,
                          value: e.toString(),
                          groupValue: nivelselecionado,
                          onChanged: (value) {
                            setState(() {
                              nivelselecionado = value.toString();
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
                            value: linguagemSelecionadas.contains(linguagem),
                            onChanged: (bool? value) {
                              if (value!) {
                                setState(() {
                                  linguagemSelecionadas.add(linguagem);
                                });
                              } else {
                                setState(() {
                                  linguagemSelecionadas.remove(linguagem);
                                });
                              }
                            },
                          ))
                      .toList(),
                ),
                const TextLabel(texto: "Tempo de Experiencia"),
                DropdownButton(
                  value: tempoExperiencia,
                  isExpanded: true,
                  items: returnItens(10),
                  onChanged: (value) {
                    setState(() {
                      tempoExperiencia = int.parse(value.toString());
                    });
                  },
                ),
                TextLabel(
                    texto:
                        "Pretenção salarial R\$ ${salarioescolhido.round()}"),
                Slider(
                  min: 0,
                  max: 10000,
                  value: salarioescolhido,
                  onChanged: (double value) {
                    setState(() {
                      salarioescolhido = value;
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
                      if (dataNasc == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("data nascimento invalida")));
                        return;
                      }
                      if (nivelselecionado.trim() == "") {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "o nivel deve ser selecionado nascimento invalida")));
                        return;
                      }
                      if (linguagemSelecionadas.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "deve ser selecionado no mimino uma linguagem")));
                        return;
                      }
                      if (salarioescolhido == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("selecionar salario")));
                        return;
                      }
                      await storage.setDadosNome(nomeController.text);
                      await storage.setDadosDataNasc(dataNasc!);
                      await storage.setDadosNivel(nivelselecionado);
                      await storage.setDadosLinguagens(linguagemSelecionadas);
                      await storage.setDadosExperiencia(tempoExperiencia);
                      await storage.setDadosSalario(salarioescolhido);

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
