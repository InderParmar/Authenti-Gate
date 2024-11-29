import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RegisterPage(),
  ));
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  String _contactNumber = '';
  String _authType = 'Face'; // Default value

  Future<void> _registerUser() async {
    final url = Uri.parse('http://localhost:8080/api/users/register'); // Update your API endpoint
    final body = jsonEncode({
      "firstName": _firstName,
      "lastName": _lastName,
      "email": _email,
      "password": _password,
      "contactNumber": _contactNumber,
      "authType": _authType,
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        // Registration successful, navigate to success screen
        _showCameraAccessDialog();
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registration failed: ${response.body}"),
          ),
        );
      }
    } catch (error) {
      // Handle network or other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $error"),
        ),
      );
    }
  }

  Future<void> _showCameraAccessDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Camera Access Required"),
        content: Text(
          "To complete the registration, the system needs access to your camera to set up face authentication. Please allow it when prompted.",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _navigateToSuccessScreen();
            },
            child: Text("OK", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  void _navigateToSuccessScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SuccessScreen(authType: _authType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Secret service theme gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              width: 400,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Register User",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: Color(0xFF00C6FF),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      label: "First Name",
                      icon: Icons.person,
                      onSave: (value) => _firstName = value!,
                      validator: (value) {
                        if (value!.isEmpty) return "First Name is required";
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return "Only letters and spaces are allowed";
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      label: "Last Name",
                      icon: Icons.person_outline,
                      onSave: (value) => _lastName = value!,
                      validator: (value) {
                        if (value!.isEmpty) return "Last Name is required";
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return "Only letters and spaces are allowed";
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      label: "Email",
                      icon: Icons.email,
                      onSave: (value) => _email = value!,
                      validator: (value) {
                        if (value!.isEmpty) return "Email is required";
                        if (!RegExp(
                                r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                            .hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _buildTextField(
                      label: "Password",
                      icon: Icons.lock,
                      obscureText: true,
                      onSave: (value) => _password = value!,
                      validator: (value) =>
                          value!.isEmpty ? "Password is required" : null,
                    ),
                    _buildTextField(
                      label: "Contact Number",
                      icon: Icons.phone,
                      onSave: (value) => _contactNumber = value!,
                      validator: (value) {
                        if (value!.isEmpty) return "Contact Number is required";
                        if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return "Only numbers are allowed";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Authentication Type",
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      dropdownColor: Colors.black,
                      value: _authType,
                      onChanged: (value) => setState(() {
                        _authType = value as String;
                      }),
                      items: [
                        DropdownMenuItem(
                          value: "Face",
                          child: Row(
                            children: [
                              Icon(Icons.face, color: Color(0xFF00C6FF)),
                              SizedBox(width: 10),
                              Text("Face", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Face + Fingers",
                          child: Row(
                            children: [
                              Icon(Icons.face, color: Color(0xFF00C6FF)),
                              SizedBox(width: 5),
                              Icon(Icons.fingerprint, color: Color(0xFF00C6FF)),
                              SizedBox(width: 10),
                              Text("Face + Fingers",
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 60,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Color(0xFF00C6FF),
                        shadowColor: Colors.black38,
                        elevation: 5,
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _registerUser();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required FormFieldSetter<String> onSave,
    required FormFieldValidator<String> validator,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(icon, color: Color(0xFF00C6FF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF00C6FF)),
          ),
        ),
        onSaved: onSave,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  final String authType;

  SuccessScreen({required this.authType});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified, size: 100, color: Color(0xFF00C6FF)),
                  SizedBox(height: 20),
                  Text(
                    "Registration Successful!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "You are registered with $authType authentication.",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
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
