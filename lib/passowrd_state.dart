class PassoredState {}

class PassoredInitial extends PassoredState {}

class PassoredLoading extends PassoredState {}

class PassoredSuccess extends PassoredState {}

class PassoredError extends PassoredState {
  String error;
  PassoredError({required this.error});
}