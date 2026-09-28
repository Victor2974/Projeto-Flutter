import 'package:flutter/material.dart';
import 'geracao_de_energia_screen.dart';
import 'consumo_de_energia_screen.dart';
import 'meta_de_reciclagem_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildMenuButton({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Widget targetScreen,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => targetScreen),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista 10 — Menu Principal'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Escolha uma das calculadoras abaixo:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            _buildMenuButton(
              context: context,
              title: 'Geração de Energia Solar',
              icon: Icons.wb_sunny_outlined,
              targetScreen: const GeracaoDeEnergiaScreen(),
            ),
            _buildMenuButton(
              context: context,
              title: 'Consumo de Energia',
              icon: Icons.electric_bolt_outlined,
              targetScreen: const ConsumoDeEnergiaScreen(),
            ),
            _buildMenuButton(
              context: context,
              title: 'Meta de Reciclagem',
              icon: Icons.recycling_outlined,
              targetScreen: const MetaDeReciclagemScreen(),
            ),
          ],
        ),
      ),
    );
  }
}