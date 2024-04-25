import 'package:flutter/material.dart';
import 'package:wallet_binance/views/signup_screen.dart';
import 'package:wallet_binance/views/login_screen.dart';

import '../main.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildPage(
        title: 'Bienvenido a CryptoTracker',
        description: 'Sigue los precios de tus criptomonedas favoritas.',
      ),
      _buildPage(
        title: 'Monitoreo en Tiempo Real',
        description: 'Obtén actualizaciones en tiempo real del mercado.',
      ),
      _buildPage(
        title: 'Alertas y Notificaciones',
        description: 'Nunca te pierdas los cambios críticos en el mercado.',
      ),
    ];
  }

  Widget _buildPage({required String title, required String description}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: binanceYellow),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.0),
          Text(
            description,
            style: TextStyle(fontSize: 18.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? binanceYellow : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _pages.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      color: binanceGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: binanceBlue, // Color del fondo del botón
              onPrimary: Colors.white, // Color del contenido del botón
            ),
            child: Text('Iniciar Sesión'),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: binanceYellow, // Color del fondo del botón
              onPrimary: Colors.black, // Color del texto
            ),
            child: Text('Registrarse'),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: binanceGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _currentPage != 0
            ? IconButton(
          icon: Icon(Icons.arrow_back, color: binanceYellow),
          onPressed: () {
            _pageController.previousPage(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
        )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PageView(
          controller: _pageController,
          children: _pages,
          onPageChanged: (int page) {
            setState(() => _currentPage = page);
          },
        ),
      ),
      bottomSheet: _currentPage == _pages.length - 1
          ? _buildBottomNavigationBar()
          : Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
      ),
    );
  }
}
