import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  ProfileScreen({required this.username, Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _selectedImage;
  final db = FirebaseFirestore.instance;
  String? email;
  String? name;

  void getData() async {
    QuerySnapshot snapshot = await db
        .collection("LOGIN")
        .where("username", isEqualTo: widget.username)
        .get();
    snapshot.docs.forEach((QueryDocumentSnapshot doc) {
      var data = doc.data() as Map<String, dynamic>;
      var data2 = doc.data() as Map<String, dynamic>;
      if (doc.exists) {
        email = data["email"];

        if (data2["name2"] != " ") {
          name = data2["name"] + " " + data2["name2"] + " " + data2["surname"];
        } else {
          name = data2["name"] + " " + data2["surname"];
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: ListView(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          Center(
            child: CircleAvatar(
              backgroundImage:
                  _selectedImage != null ? FileImage(_selectedImage!) : null,
              child: GestureDetector(
                onTap: () => ShowSelectedImage(context),
                child: _selectedImage == null
                    ? Icon(
                        Icons.edit,
                        size: 60.0,
                      )
                    : null,
              ),
              radius: 80,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          ProfileData("@" + widget.username),
          ProfileData(email),
          ProfileData(name),
        ],
      ),
    );
  }

  Text ProfileData(dynamic textData) => Text(
        textData != null ? textData.toString() : "",
        style: GoogleFonts.bebasNeue(
          fontSize: 28.0,
        ),
      );

  void ShowSelectedImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("Galeriden Foto Seç"),
              onTap: () => SelectedDownload(ImageSource.gallery),
            ),
            ListTile(
              title: Text("Kameradan Yükle"),
              onTap: () => SelectedDownload(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> SelectedDownload(ImageSource source) async {
    final picker = ImagePicker();
    final selected = await picker.pickImage(source: source);

    setState(() {
      if (selected != null) {
        _selectedImage = File(selected.path);
      }
    });
    Navigator.pop(context);
  }
}
