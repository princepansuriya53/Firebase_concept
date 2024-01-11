import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_work/Screen/Auth/Google_auth.dart';
import 'package:firebase_work/Screen/Auth/Login-screen.dart';
import 'package:firebase_work/Screen/Post/add_post.dart';
import 'package:firebase_work/Utility/utlity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Post_screen extends StatefulWidget {
  Post_screen({Key? key});

  @override
  State<Post_screen> createState() => _Post_screenState();
}

class _Post_screenState extends State<Post_screen> {
  final auth = FirebaseAuth.instance;

  final ref = FirebaseDatabase.instance.ref('Post');

  final searchFilter = TextEditingController();

  final editingFilter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                });
                googleLogout();
              },
              icon: const Icon(Icons.power_settings_new_outlined))
        ],
        title: Text('Post', style: GoogleFonts.alike(fontSize: 20.h)),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              autofillHints: const [AutofillHints.username],
              keyboardType: TextInputType.emailAddress,
              autocorrect: true,
              onTap: () => FocusScope.of(context).unfocus(),
              autofocus: true,
              controller: searchFilter,
              decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.r))),
                  hintText: "Search"),
              onChanged: (String value) => setState(() {}),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: FirebaseAnimatedList(
              shrinkWrap: true,
              defaultChild: const Center(
                  child: CircularProgressIndicator(
                      strokeWidth: 2, strokeAlign: 2)),
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                final Name = snapshot.child("Name").value.toString();

                if (searchFilter.text.isEmpty) {
                  return ListTile(
                    autofocus: true,
                    title: Text(snapshot.child("Name").value.toString()),
                    subtitle: Text(snapshot.child("id").value.toString()),
                    trailing: PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                showMyDialog(
                                  Name,
                                  snapshot.child("id").value.toString(),
                                );
                              },
                              title: const Text("Edit"),
                              leading: const Icon(Icons.edit_document)),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                ref
                                    .child(
                                        snapshot.child("id").value.toString())
                                    .remove();
                              },
                              title: const Text("Delete"),
                              leading: const Icon(Icons.delete_sharp)),
                        ),
                      ],
                    ),
                  );
                } else if (Name.toLowerCase()
                    .contains(searchFilter.text.toLowerCase().toLowerCase())) {
                  return ListTile(
                    title: Text(snapshot.child("Name").value.toString()),
                    subtitle: Text(snapshot.child("id").value.toString()),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Add_post()),
            );
          },
          child: const Icon(Icons.add)),
    );
  }

  Future<void> showMyDialog(String Name, String id) async {
    editingFilter.text = Name;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                ref.child(id).update(
                  {
                    "Name": editingFilter.text.toString(),
                  },
                ).then(
                  (value) {
                    Tost().Message(
                      "Post Updated",
                    );
                  },
                ).onError(
                  (error, stackTrace) {
                    Tost().Message(
                      error.toString(),
                    );
                  },
                );
                Navigator.pop(context);
              },
            ),
          ],
          title: const Text('Update'),
          content: TextFormField(
            controller: editingFilter,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        );
      },
    );
  }
}
