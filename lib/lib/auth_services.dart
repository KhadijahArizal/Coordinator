import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

//google sign in
  Future<void> handlesSignin() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      print("Error signin with Google $e");
    }
  }

//google sign out

  Future<void> handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print("error sign ou $e");
    }
  }
}
