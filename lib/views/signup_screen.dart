import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../main.dart';
import 'login_screen.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _emailError = '';
  String _passwordError = '';

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
    _confirmPasswordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateButtonState);
    _passwordController.removeListener(_updateButtonState);
    _confirmPasswordController.removeListener(_updateButtonState);
    super.dispose();
  }

  void _updateButtonState() {
    // Verifica las condiciones de validación y actualiza el estado del botón
   setState(() {
        _emailError = _emailController.text.isNotEmpty && !isEmailValid(_emailController.text)
            ? 'Correo electrónico no válido'
            : '';
        _passwordError = _passwordController.text.isNotEmpty && !isPasswordValid(_passwordController.text)
            ? 'La contraseña debe tener al menos 8 caracteres'
            : '';
      });
  }

  bool get _isRegisterButtonEnabled {
    // Comprueba si los campos están llenos y son válidos
    return _emailController.text.isNotEmpty &&
        isEmailValid(_emailController.text) &&
        _passwordController.text.isNotEmpty &&
        isPasswordValid(_passwordController.text) &&
        _passwordController.text == _confirmPasswordController.text;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: binanceGrey,
      body: Center( // Centra el contenido vertical y horizontalmente
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
              _buildTextField(
                controller: _emailController,
                labelText: 'Correo electrónico',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: _passwordController,
                labelText: 'Contraseña',
                icon: Icons.lock,
                obscureText: true, // Ocultar contraseña
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                controller: _confirmPasswordController,
                labelText: 'Confirmar Contraseña',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              SizedBox(height: 24.0),
              // Botón para registrar
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: binanceBlue, // Color de Binance
                  onPrimary: Colors.white, // Color del texto
                  minimumSize: Size(double.infinity, 50), // Tamaño del botón
                ),
                onPressed: _isRegisterButtonEnabled ? () {
                  final authService = Provider.of<AuthService>(context, listen: false);
                  authService.signUp(_emailController.text, _passwordController.text)
                      .then((_) {
                    Navigator.pushReplacementNamed(context, '/login');
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error.toString())),
                    );
                  });
                } : null,
                child: Text('Registrar'),
              ),
              // Enlace para cambiar a la pantalla de inicio de sesión
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white, // Color del texto
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('¿Ya tienes una cuenta? Inicia sesión'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }

  // Método auxiliar para crear campos de texto con estilos comunes
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
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
          borderSide: BorderSide(color: binanceBlue.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: binanceYellow),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      cursorColor: binanceYellow,
      keyboardType: keyboardType,
    );
  }

  bool isEmailValid(String email) {
    return RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b').hasMatch(email);
  }

  bool isPasswordValid(String password) {
    return password.length >= 8;
  }

}
