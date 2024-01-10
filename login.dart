import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/pages/home.dart';
import 'package:login/pages/signUp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBoxMethod(100.0),
                Icon(Icons.android, size: 100.0),
                Center(
                  child: Text(
                    "EVCİL PATİ",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 52.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(247, 80, 80, 1.0),
                    ),
                  ),
                ),
                SizedBoxMethod(10.0),
                Center(
                  child: Text(
                    "Tekrar Hoşgeldiniz",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBoxMethod(35.0),
                TextFormFieldMethod(
                  "Kullanıcı Adı",
                  false,
                  _usernameController,
                ),
                SizedBoxMethod(10.0),
                TextFormFieldMethod(
                  "Parola",
                  true,
                  _passwordController,
                ),
                SizedBoxMethod(10.0),
                SignInButton(),
                SizedBoxMethod(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Kullanıcı adın yok mu ?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => SignUp()),
                          ),
                        );
                      },
                      child: Text(
                        " Şimdi kayıt ol",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Color.fromRGBO(247, 80, 80, 1.0),
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

  SizedBox SizedBoxMethod(double height) {
    return SizedBox(
      height: height,
    );
  }

  Padding TextFormFieldMethod(
    String hintText,
    bool obscureText,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(247, 80, 80, 1.0)),
            borderRadius: BorderRadius.circular(11.0),
          ),
          border: InputBorder.none,
          hintText: hintText,
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }

  Padding SignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: () => signIn(
          _usernameController.text,
          _passwordController.text,
        ),
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(247, 80, 80, 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Text(
              "Giriş",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn(String username, String password) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    final userSnapshot = await db
        .collection("LOGIN")
        .where("username", isEqualTo: username)
        .where("password", isEqualTo: password)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  username: username,
                )),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Giriş Başarısız !"),
            content: Text("Lütfen Kullanıcı Adı ve Şifrenizi kontrol edin !"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Tamam")),
            ],
          );
        },
      );
    }
  }
}
