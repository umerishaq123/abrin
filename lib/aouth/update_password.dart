import 'dart:convert';
import 'package:abrin_app_new/aouth/login.dart';
import 'package:abrin_app_new/utilis/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class CreateNewPassword extends StatefulWidget {
  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
 
  bool _isPasswordVisible = false;
  bool _isLoading = false;
 

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> _newPassword() async {
    final String email = _emailController.text;
    final String newPassword = _newPasswordController.text;

    // if (email.isEmpty || newPassword.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Please fill all the fields')),
    //   );
    //   return;
    // }
    if(email.isEmpty){
      Utils.snackBar("Veuillez entrer un email", context);
    }else if(newPassword.isEmpty){
      Utils.snackBar("Veuillez entrer un mot de passe", context);
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('https://srv562456.hstgr.cloud/api/auth/new-password');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      'email': email,
      'password': newPassword,
    });

    print('Reset Password URL: $url');
    print('Reset Password Headers: $headers');
    print('Reset Password Body: $body');

    try {
      final response = await https.post(url, headers: headers, body: body);

      print('Reset Password Response status: ${response.statusCode}');
      print('Reset Password Response body: ${response.body}');

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
       
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('OTP sent to your phone number')),
        // );
        Utils.snackBar('Mot de passe mis à jour avec succès ', context);
        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Échec de la mise à jour du mot de passe : ${response.reasonPhrase}")),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      print('Reset Password Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Échec de la mise à jour du mot de passe : $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouveau mot de passe'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Nouveau mot de passe',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ElevatedButton(
                            onPressed: _newPassword,
                            child: Text('Mettre à jour le mot de passe'),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
