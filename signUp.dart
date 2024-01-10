import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/pages/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _nameController = TextEditingController();
  final _name2Controller = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "EVCİL PATİ",
              style: GoogleFonts.bebasNeue(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(247, 80, 80, 1.0),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.android,
              size: 35,
            ),
            onPressed: () {},
          ),
        ],
        shadowColor: Colors.blueGrey[200],
        backgroundColor: Colors.blueGrey[100],
        elevation: 3.4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            children: [
              SizedBoxMethod(25.0),
              TextFormFieldMethod("İsim", _nameController, false),
              SizedBoxMethod(12.5),
              TextFormFieldMethod("İsim 2", _name2Controller, false),
              SizedBoxMethod(12.5),
              TextFormFieldMethod("Soyad", _surnameController, false),
              SizedBoxMethod(12.5),
              TextFormFieldMethod("E Mail", _emailController, false),
              SizedBoxMethod(12.5),
              TextFormFieldMethod("Kullanıcı Adı", _usernameController, false),
              SizedBoxMethod(12.5),
              TextFormFieldMethod("Parola", _passwordController, true),
              SizedBoxMethod(12.5),
              SignUpButton(),
            ],
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
    TextEditingController controller,
    bool obscureText,
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
          hintText: hintText,
          fillColor: Colors.grey[200],
          filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Padding SignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: () => SignUpTap(),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(247, 80, 80, 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Text(
              "Kayıt Ol",
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

  Future<void> SignUpTap() async {
    final name = _nameController.text;
    final name2 = _name2Controller.text;
    final surname = _surnameController.text;
    final email = _emailController.text;
    final username = _usernameController.text;
    final password = _passwordController.text;
    FirebaseFirestore db = FirebaseFirestore.instance;

    final userSnapshot = await db
        .collection("LOGIN")
        .where("username", isEqualTo: username)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Uyarı !"),
            content: Text("Böyle bir kullanıcı adı sistemde mevcut !"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Tamam")),
            ],
          );
        },
      );
    } else {
      final userSnapshot2 =
          await db.collection("LOGIN").where("email", isEqualTo: email).get();

      if (userSnapshot2.docs.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Uyarı"),
              content: Text("Böyle bir mail adresi sistemde mevcut !"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Tamam")),
              ],
            );
          },
        );
      } else {
        String url = 'http://10.0.2.2:8080/add_user?USERNAME=' +
            username.toString() +
            '&PASSWORD=' +
            password.toString() +
            '&NAME=' +
            name.toString() +
            '&NAME2=' +
            name2.toString() +
            '&SURNAME=' +
            surname.toString() +
            '&EMAIL=' +
            email.toString() +
            '&CREATEDBY=FLUTTER&CHANGEDBY=FLUTTER';

        if (name.isNotEmpty &&
            surname.isNotEmpty &&
            email.isNotEmpty &&
            username.isNotEmpty &&
            password.isNotEmpty) {
          try {
            final response = await http.post(
              Uri.parse(url),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
            );

            if (response.statusCode == 201) {
              var data = jsonDecode(response.body);
              print('Başarılı: ${data['message']}');
            } else {
              print('Başarısız: ${response.statusCode} , $url');
            }
          } catch (e) {
            print('Hata: $e');
          }

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Başarılı'),
                content: Text('Kayıt Başarılı'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => LoginPage()),
                        ),
                      );
                    },
                    child: Text('Tamam'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Uyarı !"),
                content: Text(
                    "Kayıt Başarısız, Lütfen Alanları Eksiksiz Doldurun !"),
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
  }
}
