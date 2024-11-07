import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import '../provider/edit_profile_provider.dart';
import '../provider/profile_page_provider.dart';
import '../provider/profile_provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controllers to manage input fields
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    final profile = Provider.of<ProfileProvider>(context, listen: false).profile;
    _nameController = TextEditingController(text: profile.name);
    _emailController = TextEditingController(text: profile.email);
    _numberController = TextEditingController(text: profile.number);
    _addressController = TextEditingController(text: profile.address);
  }

  @override
  Widget build(BuildContext context) {
    final editProfileProvider = Provider.of<EditProfileProvider>(context);
    final selectedImage = editProfileProvider.selectedImage;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: white,
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 24, color: white),
        ),
        backgroundColor: primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16.0),
        child: Column(
          children: [
            // Profile Photo Section
            GestureDetector(
              onTap: () => editProfileProvider.showImageSourceDialog(context),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: primary.withOpacity(0.2),
                    backgroundImage: selectedImage != null
                        ? FileImage(selectedImage)
                        : const AssetImage("assets/images/profile_photo.jpg") as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: white, width: 2),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.edit,
                        color: white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Name Input
            _buildTextField(
              label: "Name",
              controller: _nameController,
            ),
            const SizedBox(height: 16),

            // Email Input
            _buildTextField(
              label: "Email",
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Number Input
            _buildTextField(
              label: "Mobile Number",
              controller: _numberController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            // Address Input
            _buildTextField(
              label: "Address",
              controller: _addressController,
            ),
            const SizedBox(height: 30),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Call saveProfile to save changes
                  editProfileProvider.saveProfile(
                    context,
                    name: _nameController.text,
                    email: _emailController.text,
                    address: _addressController.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text("Save",style: TextStyle(color: white,fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Focus(
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;
          return TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: isFocused ? primary : Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: primary,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: primary,
                  width: 2, // Slightly thicker border when focused
                ),
              ),
            ),
          );
        },
      ),
    );
  }



  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _numberController.dispose();
    super.dispose();
  }
}
