
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:second_task/passowrd_state.dart';
import 'package:second_task/user_model.dart';

class PassworedCubit extends Cubit<PassoredState> {
  PassworedCubit() : super(PassoredInitial());

  void signUp({required UserModel user, required String password}) async {
    emit(PassoredLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: password,
          );
      user.uid = userCredential.user!.uid;

      await FirebaseFirestore.instance
          .collection('mohamed')
          .doc(userCredential.user!.uid)
          .set({
            'named': user.name,
            'age': user.age,
            'email': user.email,
            'uid': user.uid,
          });

      var box = Hive.box('text box');
      await box.put('user', user);

      emit(PassoredSuccess());
    } on FirebaseAuthException catch (e) {
      emit(PassoredError(error: e.message ?? e.toString()));
    } catch (e) {
      emit(PassoredError(error: e.toString()));
    }
  }

  void login({required String email, required String password}) async {
    emit(PassoredLoading());
    try {
      UserCredential userlogin = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('mohamed')
          .doc(userlogin.user!.uid)
          .get();

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      UserModel user2 = UserModel(
        name: data['named'],
        age: data['age'],
        email: data['email'],
        uid: data['uid'],
      );

      var box = Hive.box('text box');
      box.put('user', user2);

      emit(PassoredSuccess());
    } on FirebaseAuthException catch (e) {
      emit(PassoredError(error: e.message ?? e.toString()));
    } catch (e) {
      emit(PassoredError(error: e.toString()));
    }
  }
}
