import 'dart:io';
import 'package:chat_app/core/common/entities/user.dart';
import 'package:chat_app/core/widgets/pop_up_message.dart';
import 'package:chat_app/features/home_page/view/screen/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterServices extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  // Firebase Instances
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; // Auth Instance

  final FirebaseFirestore _fireStore =
      FirebaseFirestore.instance; // Database Instance
  final Reference _reference =
      FirebaseStorage.instance.ref(); // Storage Instance

  ChatUser? newUser;

  String? profilePicture;

  // Image upload
  UploadTask? uploadTask;
  XFile? image;

  // make sure the isLoading can only be updated from here
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // set whn the app is connecting to firebase
  void setLoading(bool value) async {
    _isLoading = value;

    notifyListeners();
  }

  Future selectImage() async {
    try {
      final picture =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picture != null) {
        final compressedFile = await compressImage(File(picture.path));
        if (compressedFile != null) {
          image = XFile(compressedFile.path);
        } else {
          image = picture;
        }
        notifyListeners();
      }
    } catch (e) {
      throw Exception("Error selecting image: $e");
    }
  }

  Future<XFile?> compressImage(File file) async {
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      '${file.parent.path}/temp_${file.path.split('/').last}',
      quality: 50,
    );
    return compressedImage;
  }

  Future<void> uploadImageToFirebase() async {
    if (image == null) {
      toastInfo("Select an image");
      return;
    }
    try {
      final ref = _reference.child(
          "images/${firstNameController.text}_${lastNameController.text}.jpg");
      uploadTask = ref.putFile(File(image!.path));
      final snapshot = await uploadTask!.whenComplete(() => null);

      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Set the downloaded firebase storage url to the profilePicture
      profilePicture = downloadUrl;
    } on FirebaseException catch (e) {
      toastInfo(e.toString());
    } catch (e) {
      toastInfo("Error uploading image");
    }
  }

  Future<UserCredential> handleRegister() async {
    String email = emailController.text.trim();
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Make sure an image has been selected if not return
    if (image == null || image!.path.isEmpty) {
      return toastInfo("No image has been selected");
    }

    if (email.isEmpty) {
      return toastInfo("Your email is empty");
    }

    if (firstName.isEmpty) {
      return toastInfo("Enter your first name");
    }

    if (lastName.isEmpty) {
      return toastInfo("Enter your last name");
    }
    if (password.isEmpty) {
      return toastInfo("Enter your password");
    }

    if (confirmPassword.isEmpty) {
      return toastInfo("Confirm your password");
    }

    if (confirmPassword != password) {
      return toastInfo("Your passwords do not match");
    }

    setLoading(true);

    try {
      // Ensure Image is uploaded first
      await uploadImageToFirebase();

      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Create a new user
      newUser = ChatUser(
        id: userCredential.user!.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        profilePicture: profilePicture!,
      );

      // set user details
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'first name': firstName,
        'last name': lastName,
        'profile picture': profilePicture,
      });

      toastInfo("You have been successfully registered");

      Get.offAll(
        () => const HomePage(),
        transition: Transition.zoom,
        duration: const Duration(milliseconds: 500),
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw toastInfo(e.code);
    } catch (e) {
      throw toastInfo(e.toString());
    } finally {
      _clearControllers();
      setLoading(false);
    }
  }

  void _clearControllers() {
    image = null;
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    firstNameController.clear();
    lastNameController.clear();
  }
}
