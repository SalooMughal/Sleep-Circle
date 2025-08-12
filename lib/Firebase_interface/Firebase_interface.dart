
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/Controller/Common_Controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../Widgets/Snack_bar.dart';
class Firebase_intefacee{
  CommonController commonController=Get.find<CommonController>();

  Future<void> deleteFirebaseAccount(String uid) async {
    try {
      // Step 1: Delete user account from Firebase Authentication
      await FirebaseAuth.instance.currentUser?.delete();

      // Step 2: Delete user data from Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();

      // You can delete additional collections or documents related to the user as needed

      Get.snackbar('Deleted Successful', 'Your account has been deleted successfully');
      print(' deleted successfully');
    } catch (error) {
      Get.snackbar('Deleted Successful', '$error');
      print('Failed to delete account: $error');
      // You can throw an exception or handle the error as per your application's requirements
    }
  }

  Future<User?> signInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      // Trigger the Google Sign In flow
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // Obtain the GoogleSignInAuthentication object
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        // Create a new credential
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Sign in to Firebase with the Google credential
        final UserCredential userCredential = await _auth.signInWithCredential(credential);

        // Get the current user
        final User? user = userCredential.user;
        print(user?.uid);
        addUserToFirestore(user!.uid, user.email.toString(), user.displayName.toString());

        return user;
      } else {
        CustomSnackBar.show('Error', 'Google Sign In failede');
        return null;
      }
    } catch (e) {
      CustomSnackBar.show('Error', '$e');
      print('Failed to sign in with Google: $e');

      return null;
    }
  }



  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString(),
        password: password.toString()
      );
      User? user = userCredential.user;

      final box=await Hive.openBox('uid');
      box.put('uid', user!.uid);
      commonController.uid.value=box.get('uid');
      commonController.checkin.value=box.get('uid');
      return user;
    } catch (e) {
      print('Error type: ${e.runtimeType}');
      print('Error details: $e');
      CustomSnackBar.show('Error', '$e');
      print('Failed to sign in with email and password: $e');
      return null;
    }

  }



  Future<void> deleteAudio(String audioUrl, String docid) async {
    try {
      // Extract the file path from the audio URL
      RegExp exp = RegExp(r'b/([^/]+)/o/(.+)\?alt=media');
      Match? match = exp.firstMatch(audioUrl);
      if (match == null) {
        print('Invalid audio URL!');
        return;
      }
      String filePath = Uri.decodeFull(match.group(2)!);

     await FirebaseFirestore.instance.collection('users').doc(commonController.uid.value).collection('Sleep_Audio').doc('${docid}').delete();
         Reference storageRef = FirebaseStorage.instance.ref().child(filePath);
      await storageRef.delete();
      Get.snackbar('Deleted Successful', 'Your sleep audio has been deleted successfully');
      print('Successfully deleted file: $filePath');
    } catch (e) {
      Get.snackbar('Error', '$e');
      print('Error deleting audio file: $e');
    }
  }  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Optional: You can perform any additional tasks after sign-out, such as clearing local data.
    } catch (e) {
      print('Error signing out: $e');
      // Handle sign-out error, if any
    }
  }


  Future<User?> signUpWithEmailAndPassword(String email, String password, String name) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      final box=await Hive.openBox('uid');
      box.put('uid', user?.uid);
      commonController.uid.value=box.get('uid');
      commonController.checkin.value=box.get('uid');
      await addUserToFirestore(user!.uid, email, name);
      return user;
    } catch (e) {
      CustomSnackBar.show('Error', '$e');
      print('Failed to sign up with email and password: $e');
      return null;
    }
  }

  Future<void> uploadFileToFirebase(File file,Duration? duration,Duration Deep_Sleep, Duration Average_Sleep,Duration Restfulness_Sleep,String Datetime,DateTime _startTime,DateTime _endTime) async {
    try {
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('sleep_audio/${DateTime.now().millisecondsSinceEpoch}.aac');
      final uploadTask = storageReference.putFile(file);
      await uploadTask;
      final downloadUrl = await storageReference.getDownloadURL();
      // Deep_Sleep += const Duration(seconds: 1200);
      // Average_Sleep += const Duration(seconds: 1200);
      // Restfulness_Sleep += const Duration(seconds: 2200);

      String formattedDate = DateFormat('MMMM d, y').format(DateTime.now());
      CollectionReference sleepAudioCollection = FirebaseFirestore.instance.collection('users').doc(commonController.uid.value).collection('Sleep_Audio');
      QuerySnapshot querySnapshot = await sleepAudioCollection.where('Date', isEqualTo: formattedDate).get();

      if(querySnapshot.docs.isEmpty){
        final response = sleepAudioCollection.doc();
        print('item id${response.id}');
        Map<String, dynamic> body = {
          'Audio': downloadUrl,
          'Duration': duration?.inSeconds,
          'Date': Datetime,
          'Deep': Deep_Sleep.inSeconds,
          'Average': Average_Sleep.inSeconds,
          'Restfulness': Restfulness_Sleep.inSeconds,
          'start_time':_startTime,
          'end_time':_endTime,
          'item_id':response.id.toString()
        };// G// Automatically generates a unique ID for the document
        await response.set(body);
      }else{
        DocumentReference existingDocRef = querySnapshot.docs.first.reference;
        print('item id${existingDocRef.id}');
        Map<String, dynamic> body = {
          'Audio': downloadUrl,
          'Duration': duration?.inSeconds,
          'Date': Datetime,
          'Deep': Deep_Sleep.inSeconds,
          'Average': Average_Sleep.inSeconds,
          'Restfulness': Restfulness_Sleep.inSeconds,
          'start_time':_startTime,
          'end_time':_endTime,
          'item_id':existingDocRef.id.toString()
        };// Get the reference of the first matching document
        await existingDocRef.update(body);
      }

      // print(respponse);


      Get.snackbar('Upload Successful', 'Your sleep audio has been uploaded to Firebase Storage.');
    } catch (e) {
      print('Upload Failed $e');
      Get.snackbar('Upload Failed', 'Failed to upload sleep audio to Firebase Storage.$e');
    }
  }



  Future<void> addUserToFirestore(String uid, String email, String name) async {
    try {
      // Reference to the users collection
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      // Add user with uid as document ID
      await users.doc(uid).set({
        'name':name,
        'email': email,
        'uid': uid,

        // Add additional fields as needed
      });

      print('User added to Firestore successfully');
    } catch (e) {
      print('Failed to add user to Firestore: $e');
    }
  }
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Notify the user that the password reset email was sent
      print('Password reset email sent');
    } catch (e) {
      // Handle error
      print('Failed to send password reset email: $e');
    }
  }

}