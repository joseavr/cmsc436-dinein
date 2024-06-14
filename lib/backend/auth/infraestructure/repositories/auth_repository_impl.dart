import 'package:fpdart/fpdart.dart';
import 'package:group_project/backend/auth/infraestructure/sources/auth_supabase_api.dart';
import 'package:group_project/backend/auth/domain/repositories/auth_repository.dart';
import 'package:group_project/backend/core/entities/user/user.dart';
import 'package:group_project/backend/core/error/exceptions.dart';
import 'package:group_project/backend/core/error/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiDataSource remoteApi; // dependency injection

  AuthRepositoryImpl({required this.remoteApi});

  @override
  Future<Either<Failure, String>> signUpWithPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      final message = await remoteApi.signUpWithPassword(
        name: name,
        email: email,
        password: password,
      );

      return right(message);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithPassword(
    String email,
    String password,
  ) async {
    try {
      await remoteApi.loginWithPassword(email: email, password: password);
      final user = await remoteApi.getServerUser();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithGoogle() async {
    try {
      await remoteApi.loginWithGoogle();
      final user = await remoteApi.getServerUser();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<void> signOut() async {
    return await remoteApi.signOut();
  }

  @override
  Future<Either<Failure, String>> sendContactForm({
    required String senderName,
    required String senderEmail,
    required String senderMessage,
  }) async {
    try {
      final result = await remoteApi.sendContactForm(
        senderName: senderName,
        senderEmail: senderEmail,
        senderMessage: senderMessage,
      );

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> updateAccount({
    String? name,
    String? email,
    String? phone,
    String? password,
  }) async {
    try {
      await remoteApi.updateProfile(
        name: name,
        email: email,
        phone: phone,
      );

      final user = await remoteApi.getServerUser();

      if (password != null && password.length > 5) {
        await remoteApi.updatePassword(password: password);
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
