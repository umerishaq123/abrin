import 'dart:convert';
import 'package:abrin_app_new/aouth/update_password.dart';
import 'package:abrin_app_new/utilis/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isOtpSent = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> _resetPassword() async {
    final String email = _emailController.text;
    // final String newPassword = _newPasswordController.text;

    // if (email.isEmpty || newPassword.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Please fill all the fields')),
    //   );
    //   return;
    // }
    if(email.isEmpty){
      Utils.snackBar("Veuillez entrer un email", context);
    }
    // else if(newPassword.isEmpty){
    //   Utils.snackBar("Veuillez entrer un mot de passe", context);
    // }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('https://srv562456.hstgr.cloud/api/auth/forgot-password');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      'email': email,
     
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
        setState(() {
          _isOtpSent = true;
        });
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('OTP sent to your phone number')),
        // );
        Utils.snackBar('OTP envoyé à votre numéro de téléphone', context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Échec de l'envoi d'OTP : ${response.reasonPhrase}")),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      print('Reset Password Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Échec de l'envoi d'OTP : $e")),
      );
    }
  }

  Future<void> _verifyOtp() async {
    final String otp = _otpController.text;

    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter the OTP')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('https://srv562456.hstgr.cloud/api/auth/verify-otp');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      'email': _emailController.text,
      'otp': otp,
    });

    print('Verify OTP URL: $url');
    print('Verify OTP Headers: $headers');
    print('Verify OTP Body: $body');

    try {
      final response = await https.post(url, headers: headers, body: body);

      print('Verify OTP Response status: ${response.statusCode}');
      print('Verify OTP Response body: ${response.body}');

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP vérifie avec succès')),
        );
         Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateNewPassword(),
                      ),
                    );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Échec de la vérification d'OTP: ${response.reasonPhrase} ")),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      print('Verify OTP Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Échec de la vérification d'OTP: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Réinitialiser le mot de passe'),
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
                // TextFormField(
                //   controller: _newPasswordController,
                //   obscureText: !_isPasswordVisible,
                //   decoration: InputDecoration(
                //     labelText: 'New Password',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     suffixIcon: IconButton(
                //       icon: Icon(
                //         _isPasswordVisible
                //             ? Icons.visibility
                //             : Icons.visibility_off,
                //       ),
                //       onPressed: _togglePasswordVisibility,
                //     ),
                //   ),
                // ),
                // SizedBox(height: 24),
                _isOtpSent
                    ? Column(
                        children: [
                          TextFormField(
                            controller: _otpController,
                            decoration: InputDecoration(
                              labelText: 'Entrez OTP',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          _isLoading
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: _verifyOtp,
                                  child: Text('Vérifier OTP'),
                                ),
                        ],
                      )
                    : _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _resetPassword,
                            child: Text('Envoyer OTP par e-mail'),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
