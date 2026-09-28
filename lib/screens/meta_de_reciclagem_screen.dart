import 'package:flutter/material.dart';
import '../models/resultado_meta_de_reciclagem.dart';

class MetaDeReciclagemScreen extends StatefulWidget {
  const MetaDeReciclagemScreen({super.key});

  @override
  State createState() => _MetaDeReciclagemScreenState();
}

class _MetaDeReciclagemScreenState extends State {
  final _formKey = GlobalKey<FormState>();
  final _pesoRecicladoController = TextEditingController();
  final _metaMensalController = TextEditingController();

  ResultadoMetaDeReciclagem? _resultado;

  void _calcularReciclagem() {
    if (_formKey.currentState!.validate()) {
      final reciclado = double.parse(_pesoRecicladoController.text.replaceAll(',', '.'));
      final meta = double.parse(_metaMensalController.text.replaceAll(',', '.'));

      final percentual = (reciclado / meta) * 100;
      final quantoFalta = meta - reciclado;

      setState(() {
        _resultado = ResultadoMetaDeReciclagem(
          percentualAtingido: percentual,
          quantoFaltaKg: quantoFalta,
        );
      });
    }
  }

  String? _validarNumero(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed <= 0) {
      return 'Informe um peso válido maior que zero';
    }
    return null;
  }

  @override
  void dispose() {
    _pesoRecicladoController.dispose();
    _metaMensalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meta de Reciclagem'),
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
                controller: _pesoRecicladoController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Peso de material reciclado no mês (kg)',
                  prefixIcon: Icon(Icons.scale),
                ),
                validator: _validarNumero,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _metaMensalController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Meta mensal de reciclagem (kg)',
                  prefixIcon: Icon(Icons.flag_outlined),
                ),
                validator: _validarNumero,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calcularReciclagem,
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
                          'Acompanhamento da Meta',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Percentual Atingido: ${_resultado!.percentualAtingido.toStringAsFixed(1)}%',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _resultado!.quantoFaltaKg > 0
                              ? 'Falta reciclar: ${_resultado!.quantoFaltaKg.toStringAsFixed(2)} kg'
                              : 'Parabéns! A meta mensal foi atingida ou superada!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _resultado!.quantoFaltaKg > 0 ? Colors.black87 : Colors.green.shade800,
                          ),
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