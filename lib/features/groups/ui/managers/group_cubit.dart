import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_quiz/features/groups/data/repo/group_repo.dart';
import 'package:light_quiz/features/groups/ui/managers/group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final GroupRepo _groupRepo;
  GroupCubit(this._groupRepo) : super(GroupInitial());

  Future<void> getAllGroups() async {
    emit(GroupLoading());
    final res = await _groupRepo.getAllGroups();

    res.fold(
      (fail) {
        emit(GroupFail(fail.errMessage));
      },
      (groups) {
        emit(GroupSuccess(groups));
      },
    );
  }

  Future<void> joinGroup({required String shortCode}) async {
    final res = await _groupRepo.joinGroup(shortCode: shortCode);

    res.fold(
      (fail) {
        emit(JoinGroupFailure(fail.errMessage));
        getAllGroups();
      },
      (groups) {
        emit(JoinGroupSuccess());
        getAllGroups();
      },
    );
  }

  Future<void> leaveGroup({required String shortCode}) async {
    final res = await _groupRepo.leaveGroup(shortCode: shortCode);

    res.fold(
      (fail) {
        emit(JoinGroupFailure(fail.errMessage));
        getAllGroups();
      },
      (groups) {
        emit(LeaveGroupSuccess());
        getAllGroups();
      },
    );
  }

  Future<void> getQuizesOfGroup({required String shortCode}) async {
    emit(GetQuizesOfGroupLoading());
    final res = await _groupRepo.getQuizesOfGroup(shortCode: shortCode);
    res.fold(
      (fail) {
        emit(GetQuizesOfGroupFailure(fail.errMessage));
      },
      (quizzes) {
        emit(GetQuizesOfGroupSuccess(quizzes));
      },
    );
  }
}
