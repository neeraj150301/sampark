import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampark/widget/my_button.dart';
import '../../controller/auth_service.dart';
import '../../widget/my_text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _profileNameFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController nameController = TextEditingController();
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  File? _profileImage; // Local profile image file
  String? _profileImageUrl; // Profile image URL
  String? _userName = ''; // Store the fetched name

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // Fetch the user's name and profile picture URL from Firestore
  Future<String?> _loadProfileData() async {
    try {
      // Assuming this function fetches some user profile data (e.g., name or URL)
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(authService.currentUser()!.uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _profileImageUrl = userData['profileImageUrl']; // Set image URL
          _userName = userData['name'] ?? authService.currentUser()!.email;
          nameController.text = userData['name'] ?? ''; // Set name if it exists
        });
        return userData['name']; // Assuming 'name' is what you need
      }
    } catch (e) {
      // print('Error loading profile data: $e');
    }
    return null; // Return null if no data is found or there's an error
  }

  // Select image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      await _uploadImage(); // Upload selected image
    }
  }

  // Upload image to Firebase Storage
  Future<void> _uploadImage() async {
    if (_profileImage == null) return;

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${authService.currentUser()!.uid}.jpg');
      await storageRef.putFile(_profileImage!);
      final imageUrl = await storageRef.getDownloadURL();

      // Update Firestore with the image URL
      await fireStore
          .collection('Users')
          .doc(authService.currentUser()!.uid)
          .update({'profileImageUrl': imageUrl});

      setState(() {
        _profileImageUrl = imageUrl; // Update local URL variable
      });
    } catch (e) {
      // print('Error uploading image: $e');
    }
  }

  // Function to save the name
  Future<void> saveUserName() async {
    String name = nameController.text;

    if (name.isNotEmpty) {
      await fireStore
          .collection('Users')
          .doc(authService.currentUser()!.uid)
          .update({'name': name});
      nameController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: Form(
        key: _profileNameFormKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _pickImage, // Allow user to pick an image on tap
              child: CircleAvatar(
                radius: 70,
                backgroundImage: _profileImageUrl != null
                    ? NetworkImage(_profileImageUrl!)
                    : (_profileImage != null
                        ? FileImage(_profileImage!)
                        : const AssetImage('assets/icons/app_padding_large.png')
                            as ImageProvider),
                child: _profileImageUrl == null && _profileImage == null
                    ? const Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: Colors.white70,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Name: ", // Fallback to email
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    _userName != ''
                        ? _userName!
                        : "${authService.currentUser()!.email}",
                    // nameController.text.isNotEmpty
                    //     ? nameController.text
                    //     : "${authService.currentUser()!.email}",
                    // name != ''
                    //     ? name!
                    //     : "${authService.currentUser()!.email}", // Fallback to email
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
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
