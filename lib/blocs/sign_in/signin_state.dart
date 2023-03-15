// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'signin_cubit.dart';

enum StatusSignIn {
  inicial,
  submetendo,
  sucesso,
  erro,
}

class SigninState extends Equatable {
  final StatusSignIn statusSignIn;
  final ErroPersonalizado erro;
  const SigninState({
    required this.statusSignIn,
    required this.erro,
  });

  factory SigninState.inicial() {
    return const SigninState(
      statusSignIn: StatusSignIn.inicial,
      erro: ErroPersonalizado(),
    );
  }

  @override
  List<Object> get props => [statusSignIn, erro];

  @override
  bool get stringify => true;

  SigninState copyWith({
    StatusSignIn? statusSignIn,
    ErroPersonalizado? erro,
  }) {
    return SigninState(
      statusSignIn: statusSignIn ?? this.statusSignIn,
      erro: erro ?? this.erro,
    );
  }
}
