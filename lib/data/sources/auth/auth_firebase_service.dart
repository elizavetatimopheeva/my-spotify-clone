import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/singin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signin(SinginUserReq singinUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signin(SinginUserReq singinUserReq) async{
     try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: singinUserReq.email,
        password: singinUserReq.password,
      );
      return const Right("Signin was successful");
    } on FirebaseAuthException catch (e) {
      String message='';

      if(e.code == 'invalid-email'){
        message = "No user found for that email";
      } else if (e.code == 'invelid-credential'){
        message = "Wrong password";
      }

      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      FirebaseFirestore.instance.collection("Users").doc(data.user?.uid).
      set({
        'name' : createUserReq.fullName,
        'email':data.user?.email

      });
      return const Right("Signup was successful");
    } on FirebaseAuthException catch (e) {
      String message='';

      if(e.code == 'weak-password'){
        message = "The password provided is too weak";
      } else if (e.code == 'email-already-in-use'){
        message = "An account already exists with that email";
      }

      return Left(message);
    }
  }
}
