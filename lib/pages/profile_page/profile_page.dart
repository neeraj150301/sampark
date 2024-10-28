import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/widget/my_button.dart';
import '../../controller/auth_service.dart';
import '../../widget/my_text_field.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final _profileNameFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    final TextEditingController nameController = TextEditingController();
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;

    // Fetch the user's name from Firestore
    Future<String?> getUserName() async {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(authService.currentUser()!.uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        return userData['name']; // Return name if it exists
      }
      return null; // Return null if no name is found
    }

    // Function to save the name
    Future<void> saveUserName() async {
      String name = nameController.text;

      if (name.isNotEmpty) {
        // Update the user's document with the name
        await fireStore
            .collection('Users')
            .doc(authService.currentUser()!.uid)
            .update({
          'name': name,
        });
        nameController.clear();
        navigator?.pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: Form(
        key: _profileNameFormKey,
        child: Column(
          children: [
            FutureBuilder<String?>(
              future: getUserName(), // Fetch the name
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Loading state
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  String? name = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Name: ", // Fallback to email
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          name != ''
                              ? name!
                              : "${authService.currentUser()!.email}", // Fallback to email
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: MyTextField(
                hintText: "Enter Name",
                obscureText: false,
                controller: nameController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: MyButton(
                  text: const Text('Save'),
                  onPressed: () async {
                    if (_profileNameFormKey.currentState!.validate()) {
                      await saveUserName();
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
