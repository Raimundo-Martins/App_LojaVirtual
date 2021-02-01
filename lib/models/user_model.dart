import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String senha,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _firebaseAuth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: senha)
        .then((user) async {
      firebaseUser = user;

      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((erro) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {@required String email,
      @required String senha,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((user) async {
      firebaseUser = user;

      await _loadCurrentUser();

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((erro) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _firebaseAuth.signOut;

    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void recoverPass(String email) {
    _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .setData(userData);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _firebaseAuth.currentUser();
    if (firebaseUser != null) {
      if (userData['nome'] == null) {
        DocumentSnapshot documentSnapshot = await Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .get();
        userData = documentSnapshot.data;
      }
    }
    notifyListeners();
  }
}
