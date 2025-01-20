import 'package:flutter/material.dart';
import 'package:BemCasados/widgets/MyWeddingActions.dart';
import 'package:BemCasados/widgets/WeddingCountdown.dart';
import 'package:provider/provider.dart';
import 'package:BemCasados/model/userList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  DateTime? weddingDate;

  @override
  void initState() {
    super.initState();
    _loadWeddingDate();
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
    final userList = Provider.of<UserList>(context);
    final username = userList.currentUser?.username ?? 'Usuário';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4.0),
          Text(
            'Bem-Vindo(a), $username',
            style: const TextStyle(
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
              child: const Text('Quando será meu casamento?'),
            )
          else
            WeddingCountdown(
              imageUrl: 'assets/images/0008-danibruno_pw-1000x668.png',
              title: 'Meu Casamento',
              countdownText: _calculateTimeUntilWedding(weddingDate!),
              onExpand: () {
                // Lógica para expandir o card
              },
              onEdit: () => _pickWeddingDate(context),
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
                          icon: const Icon(Icons.checklist),
                          onTap: () {},
                        ),
                        MyWeddingActions(
                          buttonLabel: "Meus fornecedores",
                          icon: const Icon(Icons.business),
                          onTap: () {},
                        ),
                        MyWeddingActions(
                          buttonLabel: "Orçamentos",
                          icon: const Icon(Icons.attach_money),
                          onTap: () {},
                        ),
                        MyWeddingActions(
                          buttonLabel: "Lista de convidados",
                          icon: const Icon(Icons.group),
                          onTap: () {},
                        ),
                        MyWeddingActions(
                          buttonLabel: "Lista de presentes",
                          icon: const Icon(Icons.card_giftcard),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
