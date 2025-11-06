import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final int? currentUserId;

  const AppState({this.currentUserId});

  AppState copyWith({int? currentUserId}) {
    return AppState(currentUserId: currentUserId ?? this.currentUserId);
  }

  @override
  List<Object?> get props => [currentUserId];
}
