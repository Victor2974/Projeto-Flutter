import 'package:flutter/material.dart';
import '../models/resultado_geracao_de_energia.dart';

class GeracaoDeEnergiaScreen extends StatefulWidget {
  const GeracaoDeEnergiaScreen({super.key});

  @override
  State createState() => _GeracaoDeEnergiaScreenState();
}

class _GeracaoDeEnergiaScreenState extends State {
  final _formKey = GlobalKey<FormState>();
  final _areaController = TextEditingController();
  final _horasController = TextEditingController();
  final _eficienciaController = TextEditingController();

  ResultadoGeracaoDeEnergia? _resultado;

  void _calcularEnergia() {
    if (_formKey.currentState!.validate()) {
      final area = double.parse(_areaController.text.replaceAll(',', '.'));
      final horas = double.parse(_horasController.text.replaceAll(',', '.'));
      final eficiencia = double.parse(_eficienciaController.text.replaceAll(',', '.'));

      final energiaGerada = area * horas * (eficiencia / 100);

      setState(() {
        _resultado = ResultadoGeracaoDeEnergia(energiaGeradaKwh: energiaGerada);
      });
    }
  }

  String? _validarNumero(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed <= 0) {
      return 'Informe um número válido e maior que zero';
    }
    return null;
  }

  @override
  void dispose() {
    _areaController.dispose();
    _horasController.dispose();
    _eficienciaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geração de Energia Solar'),
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
                controller: _areaController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Área do painel solar (m²)',
                  prefixIcon: Icon(Icons.aspect_ratio),
                ),
                validator: _validarNumero,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _horasController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Horas de sol por dia',
                  prefixIcon: Icon(Icons.access_time),
                ),
                validator: _validarNumero,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _eficienciaController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Eficiência do painel (%)',
                  prefixIcon: Icon(Icons.percent),
                ),
                validator: _validarNumero,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calcularEnergia,
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
                          'Resultado da Estimativa',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Energia Gerada por Dia: ${_resultado!.energiaGeradaKwh.toStringAsFixed(2)} kWh',
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
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