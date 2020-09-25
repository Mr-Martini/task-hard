part of 'tagednoteshomebloc_bloc.dart';

abstract class TagednoteshomeblocEvent extends Equatable {
  const TagednoteshomeblocEvent();

  @override
  List<Object> get props => [];
}

class GetPreference extends TagednoteshomeblocEvent {
  @override
  List<Object> get props => [];
}

class SetPreference extends TagednoteshomeblocEvent {
  final bool should;

  SetPreference({@required this.should});

  @override
  List<Object> get props => [should];
}
