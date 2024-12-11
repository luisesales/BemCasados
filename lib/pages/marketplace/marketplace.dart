import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({Key? key}) : super(key: key);

  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  String selectedCity = 'Natal, RN';

  List<String> cities = [
    'Natal, RN',
    'São Paulo, SP',
    'Rio de Janeiro, RJ',
    'Belo Horizonte, MG',
    'Porto Alegre, RS'
  ];

  final List<Map<String, String>> articles = [
    {
      'title':
          'Casamento às Cegas: Brasil - O reality show que está lançando tendência no mercado de casamentos',
      'image': 'assets/images/wedding_show.jpg',
    },
    {
      'title': 'Ideias de decorações de casamento inspiradoras para 2024',
      'image': 'assets/images/wedding_decor.jpg',
    },
    {
      'title':
          'Tendências de vestidos de noiva: Estilos para arrasar no seu grande dia',
      'image': 'assets/images/honeymoon.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Marketplace',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey[800]),
                  SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: _showCityDialog,
                    child: Text(
                      selectedCity,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[800],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Carrossel de Artigos
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: articles.map((article) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage(article['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            article['title']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Categorias',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryItem(
                      'Fotografia', 'assets/images/photo_camera.png'),
                  _buildCategoryItem('Buffet', 'assets/images/restaurant.png'),
                  _buildCategoryItem(
                      'Decoração', 'assets/images/decoration.png'),
                  _buildCategoryItem('Bolos', 'assets/images/cake.png'),
                  _buildCategoryItem('Bandas', 'assets/images/music_band.png'),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Destaques',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.0),

            _buildFeaturedItem(
              'Vestido de noiva R\$ 700',
              'Natal, Pitimbu',
              '14 de nov, 20:36',
              'assets/images/wedding_dress1.jpg',
            ),
            _buildFeaturedItem(
              'Vestido de noiva R\$ 3500',
              'Natal, Pitimbu',
              '13 de nov, 08:29',
              'assets/images/wedding_dress2.jpg',
            ),
            _buildFeaturedItem(
              'Vestido de noiva perfeito R\$ 2800',
              'Natal, Lagoa Nova',
              '12 de nov, 16:29',
              'assets/images/wedding_dress3.jpg',
            ),
          ],
        ),
      ),
    );
  }

  void _showCityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selecione a cidade'),
          content: Container(
            width: double.minPositive,
            child: ListView(
              shrinkWrap: true,
              children: cities.map((String city) {
                return ListTile(
                  title: Text(city),
                  onTap: () {
                    setState(() {
                      selectedCity = city;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryItem(String title, String iconPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[200],
            ),
            child: Image.asset(
              iconPath,
              width: 40.0,
              height: 40.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(title, style: TextStyle(fontSize: 14.0)),
        ],
      ),
    );
  }

  Widget _buildFeaturedItem(
      String title, String location, String date, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        height: 120.0,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              bottom: 8.0,
              left: 8.0,
              right: 8.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(location,
                      style: TextStyle(color: Colors.white70, fontSize: 14.0)),
                  SizedBox(height: 4.0),
                  Text(date,
                      style: TextStyle(color: Colors.white70, fontSize: 14.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
