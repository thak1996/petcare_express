import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';
import '../../exceptions/auth.exception.dart';
import '../../models/auth/user.model.dart';

abstract class IFirebaseAuthService {
  AsyncResult<UserModel> login({
    required String email,
    required String password,
  });
  AsyncResult<UserModel> register(
    String? name, {
    required String email,
    required String password,
  });
  AsyncResult<Unit> forgotPassword({required String email});
  AsyncResult<Unit> logout();
}

class FirebaseAuthServiceImpl implements IFirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthServiceImpl(this._firebaseAuth);

  @override
  AsyncResult<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final token = await response.user?.getIdToken();
      return Success(UserModel(email: response.user?.email, token: token));
    } on FirebaseAuthException catch (e) {
      return Failure(AppException.fromFirebaseAuth(e));
    } catch (e) {
      return Failure(AppException.fromType(AppErrorType.serverError));
    }
  }

  @override
  AsyncResult<UserModel> register(
    String? name, {
    required String email,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final token = await response.user?.getIdToken();
      return Success(UserModel(email: response.user?.email, token: token));
    } on FirebaseAuthException catch (e) {
      return Failure(AppException.fromFirebaseAuth(e));
    } catch (e) {
      return Failure(AppException.fromType(AppErrorType.serverError));
    }
  }

  @override
  AsyncResult<Unit> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return Success(unit);
    } on FirebaseAuthException catch (e) {
      return Failure(AppException.fromFirebaseAuth(e));
    } catch (e) {
      return Failure(AppException.fromType(AppErrorType.serverError));
    }
  }

  @override
  AsyncResult<Unit> logout() async {
    await _firebaseAuth.signOut();
    return Success(unit);
  }
}
