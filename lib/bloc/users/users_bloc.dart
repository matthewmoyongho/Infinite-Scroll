import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_test/bloc/users/users_state.dart';

import '../../data/models/user.dart';
import '../../data/repositories/users_repository.dart';
import 'users_event.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository _repository = UsersRepository();
  int page = 0;
  int limit = 15;
  UsersBloc() : super(UsersState()) {
    on<LoadUsers>(_mapLoadUsersToState);
  }

  void _mapLoadUsersToState(LoadUsers event, Emitter<UsersState> emit) async {
    final state = this.state;
    List<User> usersList = List.from(state.users);
    try {
      page++;
      List<User>? users =
          await _repository.getUsers(page.toString(), limit.toString());
      if (users == null) {
        page--;
        emit(UserError('Could not load users. Please try again'));
      } else {
        usersList.addAll(users);
        emit(UsersLoaded(usersList));
      }
    } catch (err) {
      page--;
      emit(UserError('Could not load users. Caught error'));
    }
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
