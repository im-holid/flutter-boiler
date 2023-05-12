import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiro_app/model/index.dart';
import 'package:hiro_app/riverpod/index.dart';
import 'package:hiro_app/services/get/index.dart';
import 'package:hiro_app/services/post/login.dart';

import 'package:hiro_app/theme/index.dart';
import 'package:hiro_app/widget/index.dart';

class InputPinArgumets {
  final String phone;
  final String phoneCode;

  InputPinArgumets({required this.phone, required this.phoneCode});
}

class InputPinPage extends ConsumerStatefulWidget {
  // static const routeName = '/extractArguments';
  const InputPinPage({super.key});

  @override
  ConsumerState<InputPinPage> createState() => _InputPinPageState();
}

class _InputPinPageState extends ConsumerState<InputPinPage> {
  final _pinController = TextEditingController();
  String errorStatus = '';
  InputPinArgumets? pinArgumets;

  @override
  void initState() {
    super.initState();
  }

  void _onSubmit() async {
    postLogin(
      phoneNumber: pinArgumets?.phone ?? '',
      phoneCode: pinArgumets?.phoneCode ?? '',
      pin: _pinController.text,
      context: context,
    ).then((value) {
      if (value) {
        return fetchProfile(context: context);
      }
      throw value;
    }).then((value) {
      if (value != null) {
        MemberDetail memberDetail = value;
        RiverProvider.updateMember(memberDetail: memberDetail, ref: ref);
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => route.isFirst);
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  Widget _buildAntiPin() {
    return AntiPin(
      pinController: _pinController,
      onFullfil: _onSubmit,
      errorText: errorStatus,
      onResetError: () {
        setState(() {
          errorStatus = '';
        });
      },
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              'Enter PIN'.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w500, color: hiroSwatch),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your PIN to login',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.w400, color: primaryBlackLight),
            ),
            const SizedBox(
              height: 24,
            ),
            _buildAntiPin()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    pinArgumets = ModalRoute.of(context)!.settings.arguments as InputPinArgumets;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(appBar: AntiHeader(context: context), body: _buildContent()),
    );
  }
}
