import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiro_app/model/index.dart';

MemberDetail initialState = MemberDetail();

class MemberProvider extends StateNotifier<MemberDetail> {
  MemberProvider() : super(initialState);
  void updateMemberBase({required MemberDetail memberDetail}) {
    state = memberDetail;
  }
}

final memberProvider = StateNotifierProvider<MemberProvider, MemberDetail>(
  (ref) => MemberProvider(),
);
