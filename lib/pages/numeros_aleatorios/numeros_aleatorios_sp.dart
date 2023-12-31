import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trilhaapp/services/app_storage.dart';

class NumerosAleatoriosSPPage extends StatefulWidget {
  const NumerosAleatoriosSPPage({Key? key}) : super(key: key);

  @override
  State<NumerosAleatoriosSPPage> createState() =>
      _NumerosAleatoriosSPPageState();
}

class _NumerosAleatoriosSPPageState extends State<NumerosAleatoriosSPPage> {
  int numeroGerado = 0;
  int quantidadeCliques = 0;
  AppStorageServices storage = AppStorageServices();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    numeroGerado = await storage.getNumeroAleatorio();
    quantidadeCliques = await storage.getQuantidade();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gerador de números aleatórios"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                numeroGerado.toString(),
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                quantidadeCliques.toString(),
                style: const TextStyle(fontSize: 22),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            var random = Random();
            setState(() {
              numeroGerado = random.nextInt(1000);
              quantidadeCliques = quantidadeCliques + 1;
            });
            await storage.setNumeroAleatorio(numeroGerado);
            await storage.setQuantidade(quantidadeCliques);
          },
        ),
      ),
    );
  }
}
