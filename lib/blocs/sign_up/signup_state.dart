// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'signup_cubit.dart';

enum StatusSignUp {
  inicial,
  submetendo,
  sucesso,
  erro,
}

class SignupState extends Equatable {
  final StatusSignUp statusSignUp;
  final ErroPersonalizado erro;
  const SignupState({
    required this.statusSignUp,
    required this.erro,
  });

  factory SignupState.inicial() {
    return const SignupState(
      statusSignUp: StatusSignUp.inicial,
      erro: ErroPersonalizado(),
    );
  }

  @override
  List<Object> get props => [statusSignUp, erro];

  @override
  bool get stringify => true;

  SignupState copyWith({
    StatusSignUp? statusSignUp,
    ErroPersonalizado? erro,
  }) {
    return SignupState(
      statusSignUp: statusSignUp ?? this.statusSignUp,
      erro: erro ?? this.erro,
    );
  }
}
