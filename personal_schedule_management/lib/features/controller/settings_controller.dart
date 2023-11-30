import 'package:firebase_auth/firebase_auth.dart';

class SettingsController {
  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
