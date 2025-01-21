import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final String API_KEY = 'AIzaSyD5Apzo6cOxFxXYSLflSJwxrOdfNWQ3TMk';

class ProductDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final String phone;
  final String email;
  final File image;
  final double latitude;
  final double longitude;
  final String address;

  ProductDetailScreen({
    required this.title,
    required this.description,
    required this.price,
    required this.phone,
    required this.email,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  // USAR ESTA FUNÇÃO EM DETALHES DE MARKETPLACE,
  // E NÃO AQUI.
  Future<void> _launchPhone(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Não foi possível abrir $url';
    }
  }

  // USAR ESTA FUNÇÃO EM DETALHES DE MARKETPLACE,
  // E NÃO AQUI.
  Future<void> _launchEmail(String email) async {
    final url = 'mailto:$email';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Não foi possível abrir $url';
    }
  }

  // USAR ESTA FUNÇÃO EM DETALHES DE MARKETPLACE,
  // E NÃO AQUI.
  Future<void> _launchMap(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Não foi possível abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.file(
              image,
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    address,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.indigo),
                    title: Text(phone),
                    onTap: () => _launchPhone(phone),
                  ),
                  ListTile(
                    leading: Icon(Icons.email, color: Colors.indigo),
                    title: Text(email),
                    onTap: () => _launchEmail(email),
                  ),
                  GestureDetector(
                    onTap: () => _launchMap(latitude, longitude),
                    child: Image.network(
                      'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&markers=color:red%7Clabel:P%7C$latitude,$longitude&key=$API_KEY',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
