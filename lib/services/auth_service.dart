import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:the_unwind_blog/core/constants/constant.dart';

import '../common/models/auth_id_token.dart';
import '../common/models/auth_user.dart';
import '../core/constants/constants.dart';


typedef AsyncCallBackString = Future<String> Function();

class _LoginInfo extends ChangeNotifier {
  var _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}

class AuthService {
  static final AuthService instance = AuthService._internal();

  factory AuthService() {
    return instance;
  }

  AuthService._internal();

  final _loginInfo = _LoginInfo();

  String? accessToken;
  AuthIdToken? authIdToken;
  String? idTokenRaw;
  AuthUser? profile;

  get logininfo => _loginInfo;

  /// ---------------------------------------
  ///   1 -instantiate appauth
  /// ---------------------------------------

  final appAuth = FlutterAppAuth();

  /// ---------------------------------------
  ///   2 - instantiate secure storage
  /// ---------------------------------------

  final secureStoreage = FlutterSecureStorage();

  /// ---------------------------------------
  ///   3 - init
  /// ---------------------------------------

  Future<String> init() async {
    return errorHandler(() async {
      final securedRefreshToken =
          await secureStoreage.read(key: Constant.AUTH_REFRESH_TOKEN_KEY);

      if (securedRefreshToken == null) {
        return 'You need to login!';
      }

      final response = await appAuth.token(
        TokenRequest(Constant.AUTH_CLIENT_ID, Constant.AUTH_REDIRECT_URI,
            issuer: Constant.AUTH_ISSUER, refreshToken: securedRefreshToken),
      );

      return await _setLocalVariables(response);
    });
  }

  /// ---------------------------------------
  ///   4 - login
  /// ---------------------------------------

  bool isAuthResultValide(TokenResponse? response) {
    return response?.accessToken != null && response?.idToken != null;
  }

  Future<String> _setLocalVariables(TokenResponse? result) async {
    if (this.isAuthResultValide(result)) {
      accessToken = result!.accessToken!;
      idTokenRaw = result.idToken!;
      authIdToken = parseIdToken(idTokenRaw!);

      profile = await getUserDetails(accessToken!);

      if (result.refreshToken != null) {
        await secureStoreage.write(
            key: Constant.AUTH_REFRESH_TOKEN_KEY, value: result.refreshToken);
      }

      _loginInfo.isLoggedIn = true;

      return 'SUCCESS';
    }

    return 'Passing Token went wrong';
  }

  Future<String> errorHandler(AsyncCallBackString callback) async {
    try {
      return callback();
    } on TimeoutException catch (e) {
      return e.message ?? 'Timeout Error!';
    } on FormatException catch (e) {
      return e.message;
    } on SocketException catch (e) {
      return e.message;
    } on PlatformException catch (e) {
      return e.message ?? 'Something is Wrong!';
    } catch (e) {
      return 'Unknown Error ${e.runtimeType}';
    }
  }

  Future<String> login() async {
    return errorHandler(() async {
      // Create Request
      final authorizationTokenRequest = AuthorizationTokenRequest(
          Constant.AUTH_CLIENT_ID, Constant.AUTH_REDIRECT_URI,
          issuer: Constant.AUTH_ISSUER,
          scopes: ['openid', 'profile', 'email', 'offline_access'],
          promptValues: ['login']);

      // Call Keycloak for authorize and exchange code
      final result =
          await appAuth.authorizeAndExchangeCode(authorizationTokenRequest);
      print('RESULT FROM KEYCLOAK: ${result.accessToken}');
      print('RESULT FROM KEYCLOAK: ${result.refreshToken}');
      print('RESULT FROM KEYCLOAK: ${result.accessTokenExpirationDateTime}');

      return _setLocalVariables(result);
    });
  }

  /// ---------------------------------------
  ///   5 - logout
  /// ---------------------------------------

  logout() async {
    await secureStoreage.delete(key: Constant.AUTH_REFRESH_TOKEN_KEY);

    final request = EndSessionRequest(
        idTokenHint: idTokenRaw!,
        issuer: Constant.AUTH_ISSUER,
        postLogoutRedirectUrl: Constant.AUTH_REDIRECT_URI);

    await appAuth.endSession(request);
    _loginInfo.isLoggedIn = false;
  }

  /// ---------------------------------------
  ///   6 - parseIdToken
  /// ---------------------------------------

  AuthIdToken parseIdToken(String idToken) {
    final parts = idToken.split(r'.');

    final Map<String, dynamic> json = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

    return AuthIdToken.fromJson(json);
  }

  /// ---------------------------------------
  ///   7 - getUserDetails
  /// ---------------------------------------

  Future<AuthUser> getUserDetails(String accessToken) async {
    final url = Uri.https(Constant.AUTH_DOMAIN,
        '/auth/realms/${Constant.AUTH_REALMS}/protocol/openid-connect/userinfo');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${accessToken}',
      },
    );

    if (response.statusCode == 200) {
      return AuthUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get user details!');
    }
  }
}
