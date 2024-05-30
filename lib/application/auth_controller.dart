import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:sws_assessment/presentation/home_page.dart';
import 'package:sws_assessment/presentation/login_page.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  Rx<User?> firebaseUser = null.obs;

  late Rx<GoogleSignInAccount?> googleSignInAccount;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    firebaseUser = Rx<User?>(auth.currentUser);

    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSignIn.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      isLoading.value = false;
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const HomePage());
    }
  }

  //we can create repository for these methods.
  Future<bool> signInWithGoogle() async {
    bool isSignInSuccessful = false;
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        isLoading.value = true;

        await auth.signInWithCredential(authCredential).then((value) {
          isLoading.value = false;
          isSignInSuccessful = true;
        });
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }

    return isSignInSuccessful;
  }

  void signInWithApple() async {
    try {
      final AuthorizationResult result = await TheAppleSignIn.performRequests([
        const AppleIdRequest(
          requestedOperation: OpenIdOperation.operationLogin,
          requestedScopes: [
            Scope.email,
            Scope.fullName,
          ],
        ),
      ]);
      switch (result.status) {
        case AuthorizationStatus.authorized:
          final appleIdCredential = result.credential;

          OAuthProvider oAuthProvider = OAuthProvider("apple.com");

          final credential = oAuthProvider.credential(
              idToken: String.fromCharCodes(appleIdCredential!.identityToken!),
              accessToken:
                  String.fromCharCodes(appleIdCredential.authorizationCode!));

          await auth.signInWithCredential(credential);

          Get.snackbar("Login", "Successful",
              snackPosition: SnackPosition.BOTTOM);

          break;
        case AuthorizationStatus.cancelled:
          Get.snackbar("Authorization", "Cancelled");
          break;
        case AuthorizationStatus.error:
          Get.snackbar("Authorization", "Error: ${result.error}");
          break;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    try {
      await googleSignIn.signOut();
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
