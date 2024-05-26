import 'package:flutter/material.dart';
import 'inicio_page.dart';
import 'perfil_page.dart';
import 'livroDetalhes_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BibliotecaPage(),
    );
  }
}

class BibliotecaPage extends StatefulWidget {
  @override
  _BibliotecaPageState createState() => _BibliotecaPageState();
}

class _BibliotecaPageState extends State<BibliotecaPage> {
  final List<String> bookTitles = [
    'Contos de Shakespeare',
    '10 Mil Voltas ao Mundo',
    'O Haiti de Jean',
    'Eu Sou Malala',
    'A Megera Domada',
    'Nasci em 1922',
    'Tinha um livro no meio do caminho',
    'Nariz de Vidro',
    'A colina dos suspiros',
  ];

  final List<String> bookImages = [
    'contos.jpg',
    'dezmil.jpg',
    'haiti.jpg',
    'malala.jpg',
    'megera.jpg',
    'nasci.jpg',
    'tinha.jpg',
    'narizdevidro.jpg',
    'acolinadossuspiros.jpeg',
  ];

  List<String> filteredTitles = [];
  List<String> filteredImages = [];

  int _selectedIndex = 1; // Índice da página de Biblioteca
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterBooks);
    filteredTitles = bookTitles;
    filteredImages = bookImages;
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterBooks);
    _searchController.dispose();
    super.dispose();
  }

  void _filterBooks() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredTitles = bookTitles
          .where((title) => title.toLowerCase().contains(query))
          .toList();
      filteredImages = [];
      for (int i = 0; i < bookTitles.length; i++) {
        if (bookTitles[i].toLowerCase().contains(query)) {
          filteredImages.add(bookImages[i]);
        }
      }
    });
  }

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
        title: Text('Biblioteca'),
        backgroundColor: Color(0xFFFFA500), // Cor laranja
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Implemente a lógica para filtrar as sessões
              // Isso pode abrir um menu de seleção ou uma página de filtros
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar por título',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 1 / 1.8, // Proporção de aspecto da imagem
              mainAxisSpacing: 2, // Espaçamento vertical entre as imagens
              crossAxisSpacing: 2, // Espaçamento horizontal entre as imagens
              children: List.generate(
                filteredImages.length,
                (index) => _buildBookContainer(index), // Index começa em 0
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0
                    ? Colors.orange
                    : Colors.grey), // Cor laranja se selecionado
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books,
                color: _selectedIndex == 1
                    ? Colors.orange
                    : Colors.grey), // Cor laranja se selecionado
            label: 'Biblioteca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _selectedIndex == 2
                    ? Colors.orange
                    : Colors.grey), // Cor laranja se selecionado
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedLabelStyle:
            TextStyle(color: Colors.grey), // Cor do label não selecionado
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBookContainer(int index) {
    String imageName = filteredImages[index];
    int starCount = index <= 2 ? 5 : 4;

    return GestureDetector(
      onTap: () {
        if (imageName == 'malala.jpg') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LivroDetalhesPage()),
          );
        }
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[150],
            ),
            child: Image.asset(
              'assets/$imageName', // Substitua pelo caminho da imagem do livro
              fit: BoxFit.cover,
              width: 100, // Defina a largura da imagem
              height: 150, // Defina a altura da imagem
            ),
          ),
          SizedBox(
              height: 2), // Espaçamento vertical entre a imagem e as estrelas
          StarRating(starCount: starCount),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int starCount;

  StarRating({required this.starCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 0), // Espaçamento horizontal entre as estrelas
          child: Icon(
            index < starCount ? Icons.star : Icons.star_border,
            color: Colors.orange,
            size: 16, // Tamanho das estrelas
          ),
        ),
      ),
    );
  }
}
