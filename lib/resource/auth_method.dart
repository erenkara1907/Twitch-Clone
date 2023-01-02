// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_app/model/user_model.dart';
import 'package:twitch_app/provider/user_provider.dart';
import 'package:twitch_app/utils/util.dart';

class AuthMethod {
  final _userRef = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getCurrentUser(String? uid) async {
    if (uid != null) {
      final snap = await _userRef.doc(uid).get();
      return snap.data();
    }
    return null;
  }

  Future<bool> signUp(BuildContext context, String email, String username,
      String password) async {
    bool res = false;
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null) {
        UserModel user = UserModel(
          uid: cred.user!.uid,
          username: username.trim(),
          email: email.trim(),
        );
        await _userRef.doc(cred.user!.uid).set(user.toMap());
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        res = true;
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }

  Future<bool> logIn(
      BuildContext context, String email, String password) async {
    bool res = false;
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null) {
        Provider.of<UserProvider>(context, listen: false).setUser(
          UserModel.fromMap(
            await getCurrentUser(cred.user!.uid) ?? {},
          ),
        );
        res = true;
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }
}
