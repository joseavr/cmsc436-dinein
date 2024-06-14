import 'package:google_sign_in/google_sign_in.dart';
import 'package:group_project/backend/auth/infraestructure/models/user_model.dart';
import 'package:group_project/backend/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthApiDataSource {
  Future<String> signUpWithPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginWithPassword({
    required String email,
    required String password,
  });

  Future<String> loginWithGoogle();

  Future<void> signOut();

  Future<UserModel> getServerUser();

  Future<String> sendContactForm({
    required String senderName,
    required String senderEmail,
    required String senderMessage,
  });

  Future<String> updateProfile({
    String? name,
    String? email,
    String? phone,
  });

  Future<String> updatePassword({required String password});
}

class AuthSupabaseApi implements AuthApiDataSource {
  // this can be either supabase or firebase or another service
  SupabaseClient supabase; // dependency injection

  AuthSupabaseApi({required this.supabase});

  @override
  Future<String> loginWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw ServerException(
            'Supabase API: could not login. The user was null');
      }

      return response.user!.id;
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> signUpWithPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': name.trim(),
        },
        emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/',
      );

      if (response.user?.id == null) {
        throw ServerException(
            'Ups! You could not sign up with your Crendentials.');
      }

      return "201: Sucesss";
    } on AuthException catch (e) {
      throw ServerException('Supabase error: ${e.message}');
    } catch (e) {
      throw ServerException('Server error: ${e.toString()}');
    }
  }

  @override
  Future<String> loginWithGoogle() async {
    const webClientId =
        '195808061633-osujc5ir0a5ttclqfh1kurt8tv2hvfc2.apps.googleusercontent.com';
    const iosClientId =
        '195808061633-pdcjvm5aljn2evs61r1cjluadne88t9t.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );

    try {
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      final AuthResponse response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user == null) {
        throw Error();
      }
      return response.user!.id;
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('Ups! You could not login with Google.');
    }
  }

  @override
  Future<void> signOut() async {
    return supabase.auth.signOut();
  }

  /// This should call the users table and get all data transformeed into a User
  @override
  Future<UserModel> getServerUser() async {
    final userId = supabase.auth.currentUser?.id;

    // get user from users table by id
    try {
      final json =
          await supabase.from('users').select().eq('id', userId!).single();

      return UserModel.fromJson(json);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> sendContactForm({
    required String senderName,
    required String senderEmail,
    required String senderMessage,
  }) async {
    try {
      await supabase.from('contact_us').insert({
        'sender_name': senderName,
        'sender_email': senderEmail,
        'sender_message': senderMessage,
      });

      return 'Message sent. We will contact as you soon as possible.';
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> updateProfile(
      {String? name, String? email, String? phone, String? password}) async {
    try {
      final toUpdate = {
        if (name != null && name.isNotEmpty) 'full_name': name,
        if (email != null && email.isNotEmpty) 'email': email,
        if (phone != null && phone.isNotEmpty) 'phone': phone,
      };

      await supabase
          .from('users')
          .update(toUpdate)
          .eq('id', supabase.auth.currentUser!.id);

      return '201 success';
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> updatePassword({required String password}) async {
    try {
      await supabase.auth.updateUser(
        UserAttributes(password: password),
        emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/',
      );

      return '';
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
}
