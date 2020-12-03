import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './Constant.dart';

Future<GoogleSignInAccount> googleLogin(BuildContext context) async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  try {
    await _googleSignIn.signIn();
    bool isSigned = await _googleSignIn.isSignedIn();

    if (isSigned == true) {
      return _googleSignIn.currentUser;
    } else {
      ShowToast.showDialog('Signin to Continue', context);
    }
  } catch (error) {
    print(error);
  }
  return null;
}
