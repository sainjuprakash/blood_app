part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  final AuthenticationStatus Status;
  final User? user;

  const AuthenticationState._({
    this.Status = AuthenticationStatus.unknown,
    this.user,
  });

  const AuthenticationState.unknown() : this._(Status: AuthenticationStatus.unknown);
  const AuthenticationState.authenticated(User user)
      : this._(Status: AuthenticationStatus.authenticated,user: user);
  const AuthenticationState.unauthenticated()
      : this._(Status: AuthenticationStatus.unauthenticated);
  @override
  List<Object?> get props => [Status,user];
}
