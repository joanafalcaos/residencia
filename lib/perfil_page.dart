import 'package:flutter/material.dart';
import 'inicio_page.dart'; // Importe o arquivo inicio_page.dart
import 'biblioteca_page.dart'; // Importe o arquivo biblioteca_page.dart
import 'config_page.dart'; // Importe o arquivo config_page.dart

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  int _selectedIndex = 2; // Índice da página de Perfil

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => InicioPage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BibliotecaPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PerfilPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Color(0xFFFFA500), // Cor laranja
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfigPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/foto.jpg'),
            ),
            SizedBox(height: 16),
            Text(
              'Mariana Silva dos Santos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Quantidade de Livros Lidos: 5', // Altere conforme necessário
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 25),
            _buildSectionHeader("Lista de Leitura"),
            SizedBox(height: 16),
            _buildReadingList(),
            Divider(),
            SizedBox(height: 25),
            _buildSectionHeader("Avaliações"),
            SizedBox(height: 16),
            _buildReviews(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books, color: Colors.grey),
            label: 'Biblioteca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.orange),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.orange, // Cor laranja
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildReadingList() {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          String imageName;
          if (index == 0) {
            imageName = 'contos.jpg'; // Altere para o nome da imagem
          } else if (index == 1) {
            imageName = 'dezmil.jpg'; // Altere para o nome da imagem
          } else {
            imageName = 'tinha.jpg'; // Altere para o nome da imagem
          }

          return Container(
            margin: EdgeInsets.all(8),
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[150],
            ),
            child: Image.asset(
              'assets/$imageName',
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  Widget _buildReviews() {
    return Column(
      children: [
        ListTile(
          title: Text('Haiti'), // Nome do livro
          leading: Image.asset('assets/haiti.jpg',
              width: 50, height: 50), // Ajuste de tamanho
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Avaliação: 4.5/5'), // Avaliação
              SizedBox(height: 4),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        Divider(), // Linha divisória
        ListTile(
          title: Text('Eu Sou Malala'), // Nome do livro
          leading: Image.asset('assets/malala.jpg',
              width: 50, height: 50), // Ajuste de tamanho
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Avaliação: 5/5'), // Avaliação
              SizedBox(height: 4),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
