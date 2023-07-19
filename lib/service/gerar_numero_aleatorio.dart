import 'dart:math';

class GeradorNumeroAleatorioService {
  static int aleatorio(int maximo) {
    Random numeroaleatorio = Random();

    return numeroaleatorio.nextInt(maximo);
  }
}
