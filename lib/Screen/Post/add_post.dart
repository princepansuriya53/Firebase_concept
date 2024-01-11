// ignore_for_file: deprecated_member_use

import 'package:firebase_work/Screen/Post/post.dart';
import 'package:firebase_work/Utility/utlity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class Add_post extends StatefulWidget {
  const Add_post({super.key});

  @override
  State<Add_post> createState() => _Add_postState();
}

class _Add_postState extends State<Add_post> {
  final databaseRef = FirebaseDatabase.instance.ref("Post");

  bool Loding = false;

  final PostCont = TextEditingController();

  final NameCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Post', style: GoogleFonts.allerta())),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                autofillHints: const [AutofillHints.username],
                keyboardType: TextInputType.emailAddress,
                autocorrect: true,
                validator: (value) {
                  if (value == null || value.isEmpty && value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                controller: PostCont,
                decoration: const InputDecoration(
                    labelText: "Name",
                    hintText: "Enter Name",
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(120, 50),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    setState(() => Loding = true);

                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    databaseRef
                        .child(DateTime.now().millisecondsSinceEpoch.toString())
                        .set({
                      "id": id,
                      "Name": PostCont.text.toString(),
                    }).then(
                      (value) {
                        setState(() => Loding = false);
                        Tost().Message("Post Add");
                      },
                    ).onError((error, stackTrace) {
                      setState(() {
                        Loding = false;
                      });
                      Tost().Message(error.toString());
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Post_screen(),
                        ),
                        (route) => false);
                  }
                },
                child: Center(
                    child: Loding
                        ? const SizedBox(
                            child: CircularProgressIndicator(
                                strokeAlign: 2,
                                strokeCap: StrokeCap.round,
                                color: Colors.white,
                                strokeWidth: 2),
                          )
                        : const Text('Add', textScaleFactor: 1.5)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
