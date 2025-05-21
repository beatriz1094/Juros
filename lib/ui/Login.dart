import 'package:flutter/material.dart';
import 'dart:math';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _valorMensalController = TextEditingController();
  final TextEditingController _mesesController = TextEditingController();
  final TextEditingController _taxaJurosController = TextEditingController();

  double montanteSemJuros = 0.0;
  double montanteComJuros = 0.0;

  void calcularMontantes() {
    double valorMensal = double.tryParse(_valorMensalController.text) ?? 0.0;
    int meses = int.tryParse(_mesesController.text) ?? 0;
    double taxaJuros = (double.tryParse(_taxaJurosController.text) ?? 0.0) / 100;

    montanteSemJuros = valorMensal * meses;

    montanteComJuros = valorMensal * ((pow(1 + taxaJuros, meses) - 1) / taxaJuros);

    if (taxaJuros == 0) {
      montanteComJuros = montanteSemJuros;
    }
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Juros'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: _valorMensalController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Valor Mensal',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _mesesController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Número de Meses',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _taxaJurosController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Taxa de Juros Mensal (%)',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: calcularMontantes,
              child: Text('Calcular'),
            ),
            Text('Montante Sem Juros: R\$ ${montanteSemJuros.toStringAsFixed(2)}'),
            Text('Montante Com Juros Compostos: R\$ ${montanteComJuros.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}