import 'package:flutter/material.dart';
import 'package:gluten_check/Firebase/auth_service.dart';
import 'package:gluten_check/LoginPage/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 171, 153, 94),
            Color.fromARGB(255, 194, 184, 149)
          ],
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20.0),
                        firstNameField(),
                        const SizedBox(height: 12.0),
                        lastNameField(),
                        const SizedBox(height: 12.0),
                        emailField(),
                        const SizedBox(height: 12.0),
                        passwordField(),
                        const SizedBox(height: 12.0),
                        confirmPasswordField(),
                        const SizedBox(height: 18.0),
                        registerButton(),
                        const SizedBox(height: 18.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  firstNameField() {
    return TextFormField(
      controller: firstNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) return ("İsim Boş Geçilemez");
        if (value.length < 3) return ("İsim Değeri Min. 3 Karakter Olmalı!");
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle,
            color: Color.fromARGB(255, 194, 184, 149)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'İsim',
        hintStyle: TextStyle(color: Color.fromARGB(255, 194, 184, 149)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  lastNameField() {
    return TextFormField(
      controller: lastNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) return ("Soyisim Boş Geçilemez");
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle,
            color: Color.fromARGB(255, 194, 184, 149)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Soyisim',
        hintStyle: TextStyle(color: Color.fromARGB(255, 194, 184, 149)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  emailField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) return ("Lütfen Email Girin!");
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Lütfen Email Girin");
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon:
            const Icon(Icons.email, color: Color.fromARGB(255, 194, 184, 149)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Email',
        hintStyle: TextStyle(color: Color.fromARGB(255, 194, 184, 149)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  passwordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) return ("Giriş için şifre gereklidir!");
        if (value.length < 6) return ("Şifre min 6 karakter olmalı");
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key,
            color: Color.fromARGB(255, 194, 184, 149)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Şifre',
        hintStyle: TextStyle(color: Color.fromARGB(255, 194, 184, 149)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  confirmPasswordField() {
    return TextFormField(
      controller: confirmPasswordController,
      obscureText: true,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (confirmPasswordController.text != passwordController.text) {
          return "Şifreler Eşleşmedi !";
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.vpn_key,
          color: Color.fromARGB(255, 194, 184, 149),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Şifre Doğrula',
        hintStyle: TextStyle(color: Color.fromARGB(255, 194, 184, 149)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  registerButton() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8.0), // 30.0
      color: Color.fromARGB(255, 194, 184, 149),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _authService
                .createPerson(firstNameController.text, lastNameController.text,
                    emailController.text, passwordController.text)
                .then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Kayıt Başarılı Giriş Sayfasına Yönlendiriliyorsunuz.'),
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            });
          }
        },
        child: const Text(
          'Kayıt Ol',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
