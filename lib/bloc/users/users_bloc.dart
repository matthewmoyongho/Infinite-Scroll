import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_test/bloc/users/users_state.dart';

import '../../data/models/user.dart';
import '../../data/repositories/users_repository.dart';
import 'users_event.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository repository;
  int page = 0;
  int limit = 15;
  UsersBloc(this.repository) : super(UsersState()) {
    on<LoadUsers>(_mapLoadUsersToState);
  }

  void _mapLoadUsersToState(LoadUsers event, Emitter<UsersState> emit) async {
    final state = this.state;
    if (state is UsersLoading) return;
    List<User> oldUsers = [];

    if (state is UsersLoaded) {
      oldUsers = state.users;
    }
    emit(UsersLoading(oldUsers, isFirstFetch: page == 1));
    await repository.getUsers(page).then((newUsers) {
      page++;
      final users = (this.state as UsersLoading).oldUsers;
      users.addAll(newUsers);
      emit(
        UsersLoaded(users),
      );
    });
  }

  // Stream<UsersState> mapEventToState(UsersEvent event) async* {
  //   if (event is LoadUsers) {
  //     yield* _mapLoadUsersToState(event);
  //   }
  // }

  // Stream<UsersState> _mapLoadUsersToState(LoadUsers event) async* {
  //   final state = this.state;
  //   List<User> usersList = List.from(state.users);
  //   try {
  //     page++;
  //     List<User>? users =
  //         await _repository.getUsers(page.toString(), limit.toString());
  //     if (users != null) {
  //       usersList.addAll(users);
  //       yield UsersLoaded(usersList);
  //     } else {
  //       page--;
  //       yield UserError('Could not load users');
  //     }
  //   } catch (err) {
  //     page--;
  //     yield UserError('Could not load users');
  //   }
  // }
  //   Stream<UsersState> _mapLoadindUsersToState(LoadUsers event) async* {
  //   final state = this.state;
  //
  //       yield UsersLoaded(usersList);
  //
  // }
  // void _init(InitEvent event, Emitter<UsersState> emit) async {
  //   emit(state.clone());
  // }
}
