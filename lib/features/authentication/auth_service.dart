 

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // google sign in

  googleAuth() async {
    final GoogleSignInAccount? guser = await GoogleSignIn().signIn();

    //obtain auth details

    final GoogleSignInAuthentication gauth = await guser!.authentication;

    //create new credential for a user

    final credential = GoogleAuthProvider.credential(
        accessToken: gauth.accessToken, idToken: gauth.idToken);

    //sign in
    return await  FirebaseAuth.instance.signInWithCredential(credential);
  }
}
