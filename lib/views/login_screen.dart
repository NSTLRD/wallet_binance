import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../main.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: binanceGrey,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView( //scroll
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTextField(
                  controller: _emailController,
                  labelText: 'Correo electrónico',
                  icon: Icons.email,
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  controller: _passwordController,
                  labelText: 'Contraseña',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: binanceYellow, // Background color
                    onPrimary: Colors.black, // Text and Icon color
                    minimumSize: Size(double.infinity, 50), // Set the button's size
                  ),
                  onPressed: () {
                    final authService = Provider.of<AuthService>(context, listen: false);
                    authService.signIn(_emailController.text, _passwordController.text)
                        .then((success) {
                      if (success) {
                        Navigator.pushReplacementNamed(context, '/mainScreen');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Correo electrónico o contraseña incorrectos')),
                        );
                      }
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())),
                      );
                    });
                  },
                  child: Text('Iniciar Sesión', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white, // Text color
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text('¿No tienes una cuenta? Regístrate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        fillColor: Colors.white24,
        filled: true,
        prefixIcon: Icon(icon, color: binanceBlue),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: binanceBlue.withOpacity(0.5)), // Borde más sutil
          borderRadius: BorderRadius.circular(8), // Bordes redondeados
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: binanceYellow),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      cursorColor: binanceYellow,
      keyboardType: labelText == 'Correo electrónico' ? TextInputType.emailAddress : TextInputType.text,
    );
  }
}
