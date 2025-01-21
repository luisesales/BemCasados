import 'package:BemCasados/provider/products_model.dart';
import 'package:flutter/material.dart';
import 'package:BemCasados/pages/create_product_screen.dart';
import 'package:BemCasados/widgets/CustomAppBar.dart';
import 'package:BemCasados/widgets/CustomBottomNavigationBar.dart';
import 'package:BemCasados/widgets/ProviderBottomNavigationBar.dart';
import 'package:provider/provider.dart';
import 'package:BemCasados/model/userList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:BemCasados/pages/marketplace/marketplace.dart'; // Importar a página do marketplace
import 'package:BemCasados/pages/notifications_screen.dart'; // Importar tela de notificações
import 'package:BemCasados/pages/gifts_list_page.dart'; // Importar tela de lista de presentes
import 'package:BemCasados/pages/profile_screen.dart'; // Importar tela de perfil
import 'package:BemCasados/pages/home/home_content_screen.dart';

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
    final currentUser =
        Provider.of<UserList>(context, listen: false).currentUser;
    final isProvider = currentUser?.isProvider ?? false;

    setState(() {
      _selectedIndex = index;
    });
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

  @override
  Widget build(BuildContext context) {
    // Obter o nome de usuário a partir do Provider
    final userList = Provider.of<UserList>(context);
    final currentUser = userList.currentUser;
    final isProvider = currentUser?.isProvider ?? false;

    List<Widget> _pages = [
      HomeScreenContent(),
      NotificationsScreen(),
      MarketplacePage(),
      isProvider
          ? ChangeNotifierProvider(
              create: (_) => ProductsModel(),
              child: CreateProductScreen(),
            )
          : GiftsListScreen(),
      ProfileScreen(),
    ];

    if (_selectedIndex == 0 || _selectedIndex == 2) {
      return Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: isProvider
            ? ProviderBottomNavigationBar(
                selectedIndex: _selectedIndex, onItemTapped: _onItemTapped)
            : CustomBottomNavigationBar(
                selectedIndex: _selectedIndex,
                onItemTapped: _onItemTapped,
              ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      );
    }
    return Scaffold(
      bottomNavigationBar: isProvider
          ? ProviderBottomNavigationBar(
              selectedIndex: _selectedIndex, onItemTapped: _onItemTapped)
          : CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}
