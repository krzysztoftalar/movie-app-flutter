part of 'casts_bloc.dart';

abstract class CastsState extends Equatable {
  const CastsState();

  @override
  List<Object> get props => [];
}

class CastsInitial extends CastsState {}

class CastsLoading extends CastsState {}

class CastsLoaded extends CastsState {
  final List<Cast> casts;

  CastsLoaded({
    @required this.casts,
  });

  @override
  List<Object> get props => [casts];
}

class CastsError extends CastsState {
  final String message;

  CastsError({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
