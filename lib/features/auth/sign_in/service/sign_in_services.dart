import 'dart:async';

import 'package:chat_app/core/widgets/pop_up_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInServices extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // make sure the isLoading can only be updated from here
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Check whether the device has internet connection
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  Future<void> initConnectivitySubscription() async {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      toastInfo(
        "Couldn't check connectivity status : $e",
      );
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus = result;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Login
  Future<UserCredential> handleLogIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty) {
      return toastInfo("Your email is empty");
    }
    if (password.isEmpty) {
      return toastInfo("Your password is empty");
    }

    setLoading(true);

    try {
      // hasInternet(); // Check for internet connection before proceeding

      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // after creating the user, create a new document for the user in the users collection
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));
      toastInfo("Log in Successful");

      // clearControllers();

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
    passwordController.clear();
  }
}
