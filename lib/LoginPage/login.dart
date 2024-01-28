import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gluten_check/Firebase/auth_service.dart';
import 'package:gluten_check/LoginPage/register.dart';
import 'package:gluten_check/MyHomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();
  GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
  //LoginController loginController = Get.put(LoginController());

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
                    children: [
                      glutenText(),
                      const SizedBox(height: 20.0),
                      // nameField(),
                      const SizedBox(height: 10.0),
                      emailField(),
                      const SizedBox(height: 10.0),
                      passwordField(),
                      const SizedBox(height: 28.0),
                      loginButton(),
                      const SizedBox(height: 30.0),
                      registerNowText(),
                      // const SizedBox(height: 30.0),
                      // gmailButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text glutenText() {
    return const Text(
      'GlutenCheck',
      style: TextStyle(
        color: Color.fromARGB(255, 155, 142, 99),
        fontSize: 30,
        fontWeight: FontWeight.w600,
        letterSpacing: 2,
      ),
    );
  }

  // nameField() {
  //   return TextFormField(
  //     controller: nameController,
  //     keyboardType: TextInputType.emailAddress,
  //     textInputAction: TextInputAction.next,
  //     validator: (value) {
  //       if (value!.isEmpty) return ('Lütfen İsim Girin!');
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       prefixIcon: const Icon(
  //         Icons.person,
  //         color: Colors.teal,
  //       ),
  //       contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
  //       hintText: 'İsim',
  //       hintStyle: TextStyle(color: Colors.teal),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //       ),
  //     ),
  //   );
  // }

  emailField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) return ('Lütfen Email Girin!');
        return null;
      },
      decoration: InputDecoration(
        prefixIcon:
            const Icon(Icons.mail, color: Color.fromARGB(255, 194, 184, 149)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Email',
        hintStyle: TextStyle(color: Color.fromARGB(255, 194, 184, 149)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  bool obsController = true;

  passwordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: obsController,
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value!.isEmpty) return ('Lütfen Şifre Girin!');
        if (value.length < 6) return ('Şifre Min 6 Karakter olabilir)');
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.vpn_key,
          color: Color.fromARGB(255, 194, 184, 149),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obsController == true ? Icons.visibility : Icons.visibility_off,
            color: Color.fromARGB(255, 194, 184, 149),
          ),
          onPressed: () {
            obsController == true
                ? setState(() {
                    obsController = false;
                  })
                : setState(() {
                    obsController = true;
                  });
          },
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Şifre',
        hintStyle: TextStyle(color: Color.fromARGB(255, 194, 184, 149)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  loginButton() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8.0), // 30.0
      color: Color.fromARGB(255, 194, 184, 149),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            authService
                .singIn(emailController.text, passwordController.text)
                .then(
              (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Giriş Başarılı'),
                  ),
                );
                //loginController.userUid.value = value.toString();
                // Get.offAll(() => MyHomePage());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              },
            );
          }
        },
        child: const Text(
          'Giriş Yap',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // gmailButton() {
  //   return Material(
  //     elevation: 5,
  //     borderRadius: BorderRadius.circular(8.0), // 30.0
  //     color: Color.fromARGB(255, 194, 184, 149),
  //     child: MaterialButton(
  //       padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
  //       minWidth: MediaQuery.of(context).size.width,
  //       onPressed: () {
  //         /* authService.signInWithGoogle().then(
  //           (value) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(content: Text('Google İle Giriş Yapıldı')));
  //             Get.offAll(() => MyHomePage());
  //             /*  Navigator.pushReplacement(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => RootApp(),
  //               ),
  //             ); */
  //           },
  //         ); */
  //       },
  //       child: const Text(
  //         'Google ile Giriş Yap',
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //             fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //   );
  // }

  registerNowText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Kayıtlı Değil Misin ?  ',
          style: TextStyle(fontSize: 15, fontFamily: 'comic-sans'),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              ),
            );
          },
          child: const Text(
            'Kayıt Ol',
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'comic-sans',
                color: Color.fromARGB(255, 194, 184, 149),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
