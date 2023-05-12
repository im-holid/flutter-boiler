import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiro_app/model/index.dart';
import 'package:hiro_app/riverpod/auth_token.dart';

class RiverProvider {
  static void updateMember({required MemberDetail memberDetail, required WidgetRef ref}) {
    ref.read(memberProvider.notifier).updateMemberBase(memberDetail: memberDetail);
  }
}
