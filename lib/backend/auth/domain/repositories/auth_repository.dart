import 'package:fpdart/fpdart.dart';
import 'package:group_project/backend/core/entities/user/user.dart';
import 'package:group_project/backend/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithPassword(
      String name, String email, String password);

  Future<Either<Failure, User>> loginWithPassword(
      String email, String password);

  Future<Either<Failure, User>> loginWithGoogle();

  Future<void> signOut();

  Future<Either<Failure, String>> sendContactForm({
    required String senderName,
    required String senderEmail,
    required String senderMessage,
  });

  Future<Either<Failure, User>> updateAccount({
     String? name,
     String? email,
     String? phone,
     String? password,
  });
}
