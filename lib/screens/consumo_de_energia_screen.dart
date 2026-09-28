import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/resultado_consumo_de_energia.dart';

class ConsumoDeEnergiaScreen extends StatefulWidget {
  const ConsumoDeEnergiaScreen({super.key});

  @override
  State<ConsumoDeEnergiaScreen> createState() => _ConsumoDeEnergiaScreenState();
}

class _ConsumoDeEnergiaScreenState extends State<ConsumoDeEnergiaScreen> {
  final _formKey = GlobalKey<FormState>();

  final _potenciaController = TextEditingController();
  final _horasUsoController = TextEditingController();
  final _precoKwhController = TextEditingController();

  ResultadoConsumoDeEnergia? _resultado;

  void _calcularConsumo() {
  
    if (_formKey.currentState!.validate()) {
      final potencia = double.parse(_potenciaController.text.replaceAll(',', '.'));
      final horas = double.parse(_horasUsoController.text.replaceAll(',', '.'));
      final preco = double.parse(_precoKwhController.text.replaceAll(',', '.'));

      final consumoDiario = (potencia * horas) / 1000;
      final custoMensal = consumoDiario * 30 * preco;

      setState(() {
        _resultado = ResultadoConsumoDeEnergia(
          consumoDiarioKwh: consumoDiario,
          custoMensal: custoMensal,
        );
      });
    }
  }

  String? _validarNumero(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed < 0) {
      return 'Informe um valor numérico válido';
    }
    return null;
  }

  @override
  void dispose() {
    _potenciaController.dispose();
    _horasUsoController.dispose();
    _precoKwhController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo de Energia'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _potenciaController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Potência do aparelho (Watts)',
                  prefixIcon: Icon(Icons.power),
                ),
                validator: _validarNumero,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _horasUsoController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Horas de uso por dia',
                  prefixIcon: Icon(Icons.timer),
                ),
                validator: _validarNumero,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _precoKwhController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Preço do kWh (R\$)',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: _validarNumero,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calcularConsumo,
                child: const Text('CALCULAR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 24),
              if (_resultado != null)
                Card(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Resultado do Consumo',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Consumo Diário: ${_resultado!.consumoDiarioKwh.toStringAsFixed(2)} kWh',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Custo Mensal Estimado: ${currencyFormatter.format(_resultado!.custoMensal)}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}