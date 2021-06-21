import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutors/data/utils/modal/collectionRef.dart';

class LoginBloc {
  static Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      /// saving notification token
      FirebaseMessaging.instance.subscribeToTopic('pythagon');
      String token = (await FirebaseMessaging.instance.getToken())!;
      print('Token = $token');
      CollectionRef.teachers.doc(userCredential.user!.uid).update({
        'tokens': FieldValue.arrayUnion([token])
      });

      return userCredential.user;
    }

    return null;
  }
}
