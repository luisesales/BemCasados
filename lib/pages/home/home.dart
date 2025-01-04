import 'package:flutter/material.dart';
import 'package:BemCasados/widgets/AppSearchBar.dart';
import 'package:BemCasados/widgets/CircleCartIcon.dart';
import 'package:BemCasados/widgets/CustomAppBar.dart';
import 'package:BemCasados/widgets/MyWeddingActions.dart';
import 'package:BemCasados/widgets/WeddingCountdown.dart';
import 'package:BemCasados/widgets/CustomBottomNavigationBar.dart';
import 'package:provider/provider.dart';
import 'package:BemCasados/model/userList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:BemCasados/pages/marketplace/marketplace.dart'; // Importar a página do marketplace

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // índice selecionado no BottomNavigationBar
  DateTime? weddingDate; // Variável para armazenar a data do casamento

  @override
  void initState() {
    super.initState();
    _loadWeddingDate();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // atualiza o índice selecionado
    });
  }

  void _pickWeddingDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != weddingDate) {
      setState(() {
        weddingDate = pickedDate;
      });
      _saveWeddingDate(pickedDate);
    }
  }

  void _saveWeddingDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('weddingDate', date.toIso8601String());
  }

  void _loadWeddingDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = prefs.getString('weddingDate');
    if (dateString != null) {
      setState(() {
        weddingDate = DateTime.parse(dateString);
      });
    }
  }

  String _calculateTimeUntilWedding(DateTime weddingDate) {
    final now = DateTime.now();
    final difference = weddingDate.difference(now);
    final months = difference.inDays ~/ 30;
    final days = difference.inDays % 30;
    final hours = difference.inHours % 24;
    return '$months meses, $days dias, $hours horas';
  }

  @override
  Widget build(BuildContext context) {
    // Obter o nome de usuário a partir do Provider
    final userList = Provider.of<UserList>(context);
    final username = userList.currentUser?.username ??
        'Usuário'; // Obtém o username do usuário logado

    List<Widget> _pages = <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4.0),
          Text(
            'Bem-Vindo(a), $username',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          const Text(
            'Continue os preparativos para o seu casamento',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 16.0),
          if (weddingDate == null)
            ElevatedButton(
              onPressed: () => _pickWeddingDate(context),
              child: Text('Quando será meu casamento?'),
            )
          else
            WeddingCountdown(
              imageUrl: 'assets/images/0008-danibruno_pw-1000x668.png',
              title: 'Meu Casamento', // Ajustado para "Meu Casamento"
              countdownText: _calculateTimeUntilWedding(weddingDate!),
              onExpand: () {
                // Lógica para expandir o card
              },
              onEdit: () => _pickWeddingDate(context), // Editar a data
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 12.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        MyWeddingActions(
                            buttonLabel: "Checklist",
                            icon: Icon(Icons.checklist),
                            onTap: () {}),
                        MyWeddingActions(
                            buttonLabel: "Meus fornecedores",
                            icon: Icon(Icons.business),
                            onTap: () {}),
                        MyWeddingActions(
                            buttonLabel: "Orçamentos",
                            icon: Icon(Icons.attach_money),
                            onTap: () {}),
                        MyWeddingActions(
                            buttonLabel: "Lista de convidados",
                            icon: Icon(Icons.group),
                            onTap: () {}),
                        MyWeddingActions(
                            buttonLabel: "Lista de presentes",
                            icon: Icon(Icons.card_giftcard),
                            onTap: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Center(child: Text('Notificações')),
      MarketplacePage(), // Página do marketplace
      Center(child: Text('Presentes')),
      Center(child: Text('Usuário')),
    ];

    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
