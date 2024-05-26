import 'package:flutter/material.dart';
import 'inicio_page.dart';
import 'biblioteca_page.dart';
import 'perfil_page.dart';
import 'login_page.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  bool recomendacoes = true;
  bool lembreteLeitura = false;

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

  void _finalizarSessao() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    // Aqui você pode adicionar qualquer lógica adicional para finalizar a sessão, como limpar dados do usuário, etc.
  }

  void _mostrarDialogoConfirmacao() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Você deseja realmente finalizar a sessão?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop();
                _finalizarSessao();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Perfil',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('Alterar Foto de Perfil'),
              onTap: () {
                // Lógica para alterar foto de perfil
              },
            ),
            ListTile(
              title: Text('Alterar Senha'),
              onTap: () {
                // Lógica para alterar senha
              },
            ),
            SizedBox(height: 20),
            Text(
              'Notificações',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text('Recomendações'),
              value: recomendacoes,
              onChanged: (bool value) {
                setState(() {
                  recomendacoes = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Lembrete de Leitura'),
              value: lembreteLeitura,
              onChanged: (bool value) {
                setState(() {
                  lembreteLeitura = value;
                });
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _mostrarDialogoConfirmacao,
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white, // Define a cor do texto para branco
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Finalizar Sessão'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0 ? Colors.orange : Colors.grey),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books,
                color: _selectedIndex == 1 ? Colors.orange : Colors.grey),
            label: 'Biblioteca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _selectedIndex == 2 ? Colors.orange : Colors.grey),
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
}
