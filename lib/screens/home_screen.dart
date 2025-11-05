import 'package:flutter/material.dart';
import 'camera_screen.dart';

class HomeScreen extends StatelessWidget {
  final String garbage;

  const HomeScreen({super.key, this.garbage = ''});

  void _startCamera(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CameraScreen(),
      ),
    );
  }

  String _getLixeiraInfo(String garbageType) {
    // Mapeamento dos tipos de lixo para as lixeiras correspondentes
    final Map<String, Map<String, dynamic>> lixeiras = {
      'plastic': {
        'nome': 'Lixeira Amarela',
        'cor': Colors.yellow[700],
        'icone': Icons.recycling,
        'descricao': 'Para materiais plásticos'
      },
      'glass': {
        'nome': 'Lixeira Verde',
        'cor': Colors.green[700],
        'icone': Icons.recycling,
        'descricao': 'Para materiais de vidro'
      },
      'paper': {
        'nome': 'Lixeira Azul',
        'cor': Colors.blue[700],
        'icone': Icons.recycling,
        'descricao': 'Para materiais de papel'
      },
      'metal': {
        'nome': 'Lixeira Vermelha',
        'cor': Colors.red[700],
        'icone': Icons.recycling,
        'descricao': 'Para materiais metálicos'
      },
      'organic': {
        'nome': 'Lixeira Marrom',
        'cor': Colors.brown[700],
        'icone': Icons.compost,
        'descricao': 'Para resíduos orgânicos'
      },
      'cardboard': {
        'nome': 'Lixeira Azul',
        'cor': Colors.blue[700],
        'icone': Icons.recycling,
        'descricao': 'Para materiais de papelão'
      },
    };

    return lixeiras[garbageType.toLowerCase()]?['nome'] ?? 'Lixeira Comum (Cinza)';
  }

  Color _getLixeiraCor(String garbageType) {
    final Map<String, Color> cores = {
      'plastic': Colors.yellow[700]!,
      'glass': Colors.green[700]!,
      'paper': Colors.blue[700]!,
      'metal': Colors.red[700]!,
      'organic': Colors.brown[700]!,
      'cardboard': Colors.blue[700]!,
    };

    return cores[garbageType.toLowerCase()] ?? Colors.grey[700]!;
  }

  IconData _getLixeiraIcone(String garbageType) {
    final Map<String, IconData> icones = {
      'plastic': Icons.recycling,
      'glass': Icons.recycling,
      'paper': Icons.recycling,
      'metal': Icons.recycling,
      'organic': Icons.compost,
      'cardboard': Icons.recycling,
    };

    return icones[garbageType.toLowerCase()] ?? Icons.delete;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "EcoClassificador",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green[700],
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.green[700],
            ),
            onPressed: () {
              _showInfoDialog(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 32),
              
              // Header principal
              _buildMainHeader(),
              
              const SizedBox(height: 40),
              
              // Botão de escaneamento
              _buildScanButton(context),
              
              // Resultado da classificação
              if (garbage.isNotEmpty) ...[
                const SizedBox(height: 40),
                _buildResultCard(),
              ],
              
              const SizedBox(height: 40),
              
              // Cards informativos
              _buildInfoCards(),
              
              const SizedBox(height: 32),
              
              // Aviso
              _buildWarningText(),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Ícone principal com background
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[400]!, Colors.green[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.recycling,
              size: 60,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 24),

          // Texto principal
          Text(
            "Classifique seus resíduos",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
              height: 1.2,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "Use inteligência artificial para identificar o tipo de lixo e descobrir onde descartar corretamente",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[500]!, Colors.green[700]!],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _startCamera(context),
          borderRadius: BorderRadius.circular(16),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                "Iniciar Classificação",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header do resultado
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green[700],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Classificação Concluída',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      garbage,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Divisor
          Container(
            height: 1,
            color: Colors.grey[200],
          ),
          
          const SizedBox(height: 24),
          
          // Informação da lixeira
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getLixeiraCor(garbage).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _getLixeiraCor(garbage).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getLixeiraCor(garbage),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _getLixeiraIcone(garbage),
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Descarte na:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getLixeiraInfo(garbage),
                        style: TextStyle(
                          fontSize: 18,
                          color: _getLixeiraCor(garbage),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Como funciona?",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: _buildInfoCard(
                icon: Icons.camera_alt,
                title: "1. Fotografe",
                description: "Tire uma foto do resíduo",
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildInfoCard(
                icon: Icons.psychology,
                title: "2. Análise IA",
                description: "Nossa IA identifica o material",
                color: Colors.purple,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildInfoCard(
                icon: Icons.recycling,
                title: "3. Descarte",
                description: "Saiba onde descartar corretamente",
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required MaterialColor color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color[600],
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWarningText() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange[600],
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'As classificações podem conter erros. Sempre verifique antes de descartar.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.orange[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sobre o EcoClassificador'),
          content: const Text(
            'Este aplicativo usa inteligência artificial para identificar tipos de resíduos e orientar sobre o descarte correto, contribuindo para a preservação do meio ambiente.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
