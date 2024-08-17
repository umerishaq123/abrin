import 'package:abrin_app_new/aouth/Handlers/aouthProviderSignup.dart';
import 'package:abrin_app_new/aouth/login.dart';
import 'package:abrin_app_new/utilis/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isOtpSent = false;
  bool _isAgreeChecked = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> _signup() async {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // if (name.isEmpty || email.isEmpty || password.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Please fill all the fields'),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    //   return;
    // }
    if (name.isEmpty) {
      Utils.snackBar('Veuillez entrer un nom', context);
    } else if (email.isEmpty) {
      Utils.snackBar('Veuillez entrer un email', context);
    } else if(password.isEmpty) {
      Utils.snackBar('Veuillez entrer un mot de passe', context);
    } 
    if (!_isAgreeChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You must agree to the terms and conditions'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthProvider>(context, listen: false).register(
        name,
        email,
        password,
      );
      setState(() {
        _isOtpSent = true;
      });
      print('Signup successful for email: $email');
    } catch (error) {
      print('Signup failed: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Échec de l inscription. L utilisateur existe déjà'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _verifyOtp() async {
    final String otp = _otpController.text;

    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veuillez saisir l'OTP"),),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthProvider>(context, listen: false).verifyOtp(otp);
      print(
          'OTP verified successfully for phone: ${Provider.of<AuthProvider>(context, listen: false).email}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP verified successfully')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LoginPage(), // Replace with your Signup screen widget
        ),
      );
      // Navigate to login or home page
    } catch (error) {
      print('OTP verification failed: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP verification failed. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _resendOtp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthProvider>(context, listen: false).resendOtp();
      print(
          'OTP resent successfully for phone: ${Provider.of<AuthProvider>(context, listen: false).email}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP renvoyé avec succès')),
      );
    } catch (error) {
      print('Failed to resend OTP: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Échec du renvoi d'OTP. Veuillez réessayer. ")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ' Bienvenue ',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6495ED),
                  ),
                ),
                SizedBox(height: 48),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
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
                SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _isAgreeChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isAgreeChecked = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        'J’accepte les termes et conditions.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                if (_isOtpSent)
                  Column(
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
                      TextButton(
                        onPressed: _resendOtp,
                        child: Text('Renvoyer OTP'),
                      ),
                    ],
                  )
                else
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                Colors.blue, // foreground (text) color
                          ),
                          onPressed: _isAgreeChecked ? _signup : null,
                          child: Text(
                            'Créer un compte',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vous avez déjà un compte ?",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Se connecter ",
                        style: TextStyle(
                          color: Color(0xFF6495ED),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
