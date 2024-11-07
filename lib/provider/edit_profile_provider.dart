import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/provider/profile_provider.dart';
import 'profile_page_provider.dart';

class EditProfileProvider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  // Getter for the selected image
  File? get selectedImage => _selectedImage;

  // Method to pick an image from gallery or camera
  Future<void> pickImage(BuildContext context, ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 80);
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
        notifyListeners(); // Notify listeners to update UI
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Show image source dialog
  void showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image From:'),
          content: const Text('Choose the image source for your profile photo.'),
          actions: [
            TextButton(
              child: const Text('Gallery'),
              onPressed: () {
                Navigator.of(context).pop();
                pickImage(context, ImageSource.gallery);
              },
            ),
            TextButton(
              child: const Text('Camera'),
              onPressed: () {
                Navigator.of(context).pop();
                pickImage(context, ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }

  // Save profile updates
  void saveProfile(BuildContext context, {
    required String name,
    required String email,
    required String address,
  }) {
    if (name.isEmpty || email.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required.')),
      );
      return;
    }

    // Update profile data in ProfileProvider
    Provider.of<ProfileProvider>(context, listen: false).updateProfile(
      name: name,
      email: email,
      address: address,
      profileImage: _selectedImage,
    );

    // Show a success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profile Saved'),
          content: const Text('Your profile has been updated successfully.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Go back to the previous screen
              },
            ),
          ],
        );
      },
    );
  }
}
